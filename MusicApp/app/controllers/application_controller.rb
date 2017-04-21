class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token]) #session as a rails object exists across all the files and between server and client browser
  end

  helper_method :current_user, :logged_in?

  def logged_in?
    return true if session[:session_token]
    false
  end

  def log_in_user!(user)
    user.reset_session_token!
    session[:session_token] = user.session_token # user.session_token is a col
  end
end
