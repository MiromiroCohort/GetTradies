class SessionsController < ApplicationController

  def new
    #render text: "good work old bot"
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
        # render text: "hello owner of #{params[:email]}. you are now logged in. session info = #{session[:user_id]}  <br> Users exists = #{user_exists}"
        redirect_to '/jobs'
      else
        session[:user_id] = nil
        # render text: "password incorrect <a href='/sessions'>Index</a>"
        redirect_to '/jobs', alert: "password incorrect"
      end
    else
      session[:user_id] = nil
      # render text: "user not found <a href='/sessions'>Index</a>"
      redirect_to '/jobs', alert: "user not found"
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
      redirect_to '/jobs', notice: "user logged out"
    end
  end

end
