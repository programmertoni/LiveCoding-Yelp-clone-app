class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :logged_in?, :current_user, :admin?, :owner?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def owner?
    logged_in? && current_user.role == 'owner'
  end

  def require_owner_or_admin?
    access_denied unless owner? || admin?
  end

  def admin?
    logged_in? && current_user.role == 'admin'
  end

  def require_admin
    access_denied unless admin?
  end

  def require_user
    access_denied unless logged_in?
  end

  def access_denied
    redirect_to login_path
    flash[:danger] = 'You have to be logged in!'
  end

  def require_same_user
    user_id = params[:user_id] || params[:id]
    access_denied unless logged_in? && session[:user_id] == user_id.to_i
  end

end
