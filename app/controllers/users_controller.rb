class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:success]   = "Welcome #{@user.full_name.titleize}! You are now logged in!"
      redirect_to root_path
    else
      render :new
    end

  end

  private

  def user_params
    params.require(:user).permit(:full_name, :password, :role)
  end

end
