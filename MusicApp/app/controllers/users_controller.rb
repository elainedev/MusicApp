class UsersController < ApplicationController

  # for signing up, creates new user
  def new
    render :new
  end

  def create
    # have user_params
    # want User object
    user = User.new(user_params)
    if user.valid?
      user.save! # could be w/o bang
      log_in_user!(user)
      redirect_to user_url(user.id) #redirect to show page with the user e.g. users/2
      # same as user_url(user)
    else
      redirect_to new_user_url
    end
  end

  def show
    shown_user = User.find_by(id: params[:id]) # <- this is from url # not params[:user][:id] b/c that is from form info, where we wrote user[email] etc
    render json: shown_user.email
    # render json: :user
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end

# params is read and extracts keys from method user_params
# params =  {
#   controller: , <-- action="users_url" in view
#   action: ,
#   user: { email: :from_form, password: :from_form}
#   # rails style to pack user params as a nested hash
# }
# params[:user] equivalent to { email: ____, password: ____}
