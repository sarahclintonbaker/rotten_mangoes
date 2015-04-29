 class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :admin

  protected

  def admin
    if current_user.admin?
      true
    else
      flash[:accessdenied] = "You must be an admin."
      redirect_to 
    end
  end

  def authorize
    unless admin?
      flash[:error] = "Must be an admin"
      redirect_to home_path
      false
    end
  end

  def restrict_access
    if !current_user
      flash[:alert] = "You must log in."
      redirect_to new_session_path
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  

end
