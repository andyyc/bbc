class LinksController < ApplicationController
  before_filter :authenticate, :only => [:create, :destroy]
  before_filter :authorized_user, :only => :destroy

  def create
    @link = current_user.links.build(params[:link])
    if @link.save
      flash[:success] = "Link created"
      redirect_to root_path
    else
      @feed_items = []
      render 'sessions/new'
    end
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
end
