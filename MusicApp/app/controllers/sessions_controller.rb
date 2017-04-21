class SessionsController < ApplicationController

  # for logging in.  No sessions database

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(params[:user][:email], params[:user][:password])
    # ^ method in user.rb model
    if user
      log_in_user!(user)
      # shows user email after log in
      redirect_to user_url(user.id)
    else
      render :new
    end
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to new_sessions_url
  end
end
