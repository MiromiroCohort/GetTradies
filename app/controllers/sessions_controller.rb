class SessionsController < ApplicationController

  def new
  end

  def index
    if User.exists?(session[:user_id])
      render text: "session id = #{session[:user_id]}, user email = #{User.find(session[:user_id]).email}"
    else
      session[:user_id] = nil
      render text: "no user session"
    end
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user
      if @user.password == params[:password]
        session[:user_id] = @user.id
        session[:expires_at] = Time.current + 1.hours
        redirect_to new_job_path
      else
        session[:user_id] = nil
        redirect_to jobs_path, alert: "password incorrect"
      end
    else
      session[:user_id] = nil
      redirect_to jobs_path, alert: "user not found"
    end

  end

  def user_exists
    if User.exists?(session[:user_id])
      true
    else
      session[:user_id] = nil
      false
    end
  end

  def destroy
    if session[:user_id]
      session[:user_id] = nil
      redirect_to jobs_path, notice: "user logged out"
    end
  end

end
