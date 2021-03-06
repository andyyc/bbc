class UsersController < ApplicationController
  before_filter :authenticate, :only => [:show]
  before_filter :correct_user, :only => [:show]
  
  def new
    @title = "Sign up"
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @title = @user.email
    @links = @user.links
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the sample app!"
      redirect_to @user
    else
      @title = "Sign up"
      render 'new'
    end
  end

  private
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

end

