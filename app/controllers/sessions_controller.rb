class SessionsController < ApplicationController
  def new
    @title = "Sign in"
    if signed_in?
      redirect_to :controller => 'links', :action => 'index'
    end
  end

  def create_extauth
    auth = request.env['omniauth.auth']
    puts auth
    unless @auth = Authorization.find_from_hash(auth)
      @auth = Authorization.create_from_hash(auth, current_user)
      puts("creating auth")
    end

    sign_in @auth.user
    redirect_back_or(root_path)
  end

  def create
    user = User.authenticate(params[:session][:email])
    if user.nil?
      flash.now[:error] = "Invalid email"
      @title = "Sign in"
      render 'new'
    else
      sign_in user
      redirect_back_or(root_path)
    end
  end
  
  def destroy
    sign_out
    redirect_to root_path
  end
end
