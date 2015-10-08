class SessionsController < ApplicationController

  def new
    redirect_to recent_reviews_path if logged_in?
  end

  def create
    user = User.find_by(full_name: params[:full_name])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success]   = "Hello #{user.full_name.titleize}! You are logged in."
      redirect_to root_path
    else
      flash[:danger] = 'There was something wrong with your Full Name or Password!'
      redirect_to login_path
    end
  end

  def destroy
    flash[:success]   = "You are logged out. We hope to see you soon!"
    session[:user_id] = nil
    redirect_to root_path
  end

end
