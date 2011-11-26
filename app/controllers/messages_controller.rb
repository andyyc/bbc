class MessagesController < ApplicationController
  before_filter :authenticate, :only => [:create, :destroy]

  def create
    puts params
    @link = Link.find(params[:link_id])
    @message = current_user.messages.build(params[:message])
    conversation_id = params[:conversation_id]
    if conversation_id
      @conversation = Conversation.find_by_id(conversation_id)
    end
    if @conversation.nil?
      @conversation = Conversation.create(:link => @link)
      ConversationUserSetting.create(:conversation => @conversation, :user => current_user)
      if current_user != @link.user
        ConversationUserSetting.create(:conversation => @conversation, :user => @link.user)
      end
    end
    @message.conversation = @conversation

    if @message.save
      flash[:success] = "Message created!"
      render 'links/show'
    else
      render 'links/show'
    end
  end

  def destroy
    #message.destroy
    #redirect_back_or root_path
  end
end
