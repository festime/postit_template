class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :logged_in?, :current_user

  def logged_in?
    # !!session[:user_id]
    !!current_user
  end

  def current_user
    # User.find(nil) throw an exception
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_user
    if !logged_in? 
      flash[:error] = "Please log in to do that."
      redirect_to login_path
    end
  end
end
