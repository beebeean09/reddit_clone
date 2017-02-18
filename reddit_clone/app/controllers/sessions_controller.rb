class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    user = User.find_by_username(user_params[:username])

    if !user.nil? && user.is_password?(user_params[:password])
      login!(user)
      redirect_to root_url
    else
      flash.now[:errors] = ["Username/Password is wrong!!!!!"]
      render :new
    end
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to new_session_url
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
