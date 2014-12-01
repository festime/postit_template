class SessionsController < ApplicationController
  
  def new
    if logged_in?
      redirect_to root_path
    else
      render :new
    end
  end

  def create
    # equivalently
    # user = User.where(username: params[:username]).first
    user = User.find_by username: params[:username]

    if user && user.authenticate(params[:password])
      flash[:notice] = "You have successfully logged in."
      session[:user_id] = user.id
      redirect_to root_path
    else 
      flash[:failure] = "Your username or password is wrong."
      render :new
    end
  end

  def destroy
    flash[:notice] = "You have successfully logged out."
    session[:user_id] = nil
    redirect_to root_path
  end
end