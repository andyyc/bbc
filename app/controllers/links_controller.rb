class LinksController < ApplicationController
  before_filter :authenticate, :only => [:create, :destroy, :show]
  before_filter :authorized_user, :only => :destroy

  def index
    @link = Link.new
    
    @feed_items = current_user.feed
    @responded_convs = Conversation.where(:visitor_id => current_user.id)

    render 'sessions/new'
  end

  def show
    @token = params[:token]
    @link = Link.find_by_token(@token)
    
    if @link.nil?
      raise ActionController::RoutingError.new('Not Found')
    end

    message_form = params[:message]
    link_user_setting_form = params[:link_user_setting]
    fb_user_node_form = params[:fb_user_node]

    @graph = Koala::Facebook::API.new(current_user.authorizations.first['token'])
    @profile = @graph.get_object("me")
    picture = @graph.get_picture("me")
    if current_user and @link
      @link_user_setting = LinkUserSetting.find_by_user_id_and_link_id(current_user.id, @link.id)

      if @link_user_setting.nil?
        @link_user_setting = LinkUserSetting.create(:link => @link, :user => current_user)
        fb_user_node = create_user_graph(@link_user_setting, @profile, picture)
      end
      @fb_user_node = @link_user_setting.fb_user_node
    end
    
    
    if current_user == @link.owner
      @conversations = current_user.conversations.find_all_by_link_id(@link.id)
      @is_owner = true
    else
      @conversation = current_user.conversations.find_by_link_id(@link.id)
      @is_owner = false
    end

    edit_message_form(request, message_form)
    edit_link_user_setting_form(request, link_user_setting_form)
    edit_fb_user_node_form(request, fb_user_node_form)

  end

  def edit_fb_user_node_form(request, fb_user_node_form)
    if request.put? and fb_user_node_form
      @fb_user_node.show_picture = fb_user_node_form['show_picture']
      @fb_user_node.show_name = fb_user_node_form['show_name']
      @fb_user_node.show_gender = fb_user_node_form['show_gender']
      @fb_user_node.show_hometown = fb_user_node_form['show_hometown']
      @fb_user_node.show_location = fb_user_node_form['show_location']
      fb_work_node_form_hash = fb_user_node_form['fb_work_node']
      if fb_work_node_form_hash
        fb_work_node_form_hash.each do |id, work_form|
          work_node = @fb_user_node.fb_work_nodes.find_by_id(id)
          work_node.show = work_form['show']
          work_node.save
        end
      end

      fb_edu_node_form_hash = fb_user_node_form['fb_education_node']
      if fb_edu_node_form_hash
        fb_edu_node_form_hash.each do |id, edu_form|
          edu_node = @fb_user_node.fb_education_nodes.find_by_id(id)
          edu_node.show = edu_form['show']
          edu_node.save
        end
      end

      if @fb_user_node.save
        flash.now[:notice] = "Settings saved"
      end
    end
  end

  def create_conversation
    conversation_id = params[:conversation_id]
    if conversation_id
      @conversation = Conversation.find_by_id(conversation_id)
    end
    if @conversation.nil?
      @conversation = Conversation.create(:link => @link, :visitor => current_user)
      ConversationUserSetting.create(:conversation => @conversation, :user=>current_user)
      if current_user != @link.owner
        ConversationUserSetting.create(:conversation => @conversation, :user=> @link.owner)
      end
    end
  end

  def edit_message_form(request, message_form)
    if request.post? and message_form
      create_conversation()
      @message = current_user.messages.build(message_form)
      @message.conversation = @conversation
      
      if @message.save
        flash.now[:notice] = "Message created!"
        @message = Message.new
      end
    else
      @message = Message.new if signed_in?
    end
  end

  def edit_link_user_setting_form(request,
                                  link_user_setting_form)
    if request.put? and link_user_setting_form
      unless @link_user_setting.nil?
        @link_user_setting.name = link_user_setting_form['name']
        if @link_user_setting.save
          flash.now[:notice] = "Name updated"
        end
      end
    end

  end

  def create
#    @link = current_user.links.build(params[:link])
    if request.post?
      @link = Link.new(params[:link])
      @link.owner = current_user
      if @link.save
        flash.now[:notice] = "Link created"
        redirect_to '/' + @link.token and return
      end
    end
    @feed_items = current_user.feed
    @responded_convs = Conversation.where(:visitor_id => current_user.id)

    render 'sessions/new'
  end

  def destroy
    @link.destroy
    redirect_back_or root_path
  end

  private
  
  def authorized_user
    @link = current_user.links.find_by_id(params[:id])
    redirect_to root_path if @link.nil?
  end

  def create_user_graph(link_user_setting, profile, picture)
    puts profile
    hometown = profile['hometown']
    if hometown
      hometown = hometown['name']
    end
    location = profile['location']
    if location
      location = location['name']
    end
    fb_user_node =  FbUserNode.create!(:link_user_setting_id => link_user_setting.id,
                                       :name => profile['name'], 
                                       :picture => picture,
                                       :link => profile['link'],
                                       :username => profile['username'],
                                       :gender => profile['gender'],
                                       :email => profile['email'],
                                       :verified => profile['verified'],
                                       :updated_time => profile['updated_time'],
                                       :hometown => hometown,
                                       :location => location,
                                       :show_name => false,
                                       :show_picture => false,
                                       :show_gender => false,
                                       :show_hometown => false,
                                       :show_location => false
                                       )
    work_array = []
    if profile['work']
      work_array = profile['work']
    end
    for work in work_array
      employer = work['employer']
      if employer
        employer = employer['name']
      end
      position = work['position']
      if position
        position = position['name']
      end
      location = work['location']
      if location
        location = location['name']
      end
      fb_work_node = FbWorkNode.create!(:employer => employer,
                                        :position => position,
                                        :location => location,
                                        :start_date => work['start_date'],
                                        :end_date => work['end_date'],
                                        :fb_user_node_id => fb_user_node.id,
                                        :show => false)
    end
    education_array = []
    if profile['education']
      education_array = profile['education']
    end
    for education in education_array
      school = education['school']
      if school
        school = school['name']
      end
      year = education['year']
      if year
        year = year['name']
      end
      degree = education['degree']
      if degree
        degree = degree['name']
      end
      type = education['type']
      fb_education_node = FbEducationNode.create!(:school => school,
                                                  :year => year,
                                                  :school_type => type,
                                                  :degree => degree,
                                                  :fb_user_node_id => fb_user_node.id,
                                                  :show => false
                                                  )
    end
    return fb_user_node
  end
end
