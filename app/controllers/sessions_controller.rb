class SessionsController < ApplicationController

  def new
    # render text: "good work old bot"
  end

  def index
    if User.exists?(session[:user_id])
      render text: "session id = #{session[:user_id]}"
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
        render text: "hello owner of #{params[:email]}. you are now logged in. session info = #{session[:user_id]}  <br> Users exists = #{user_exists}"
      else
        session[:user_id] = nil
        render text: "password incorrect <a href='/sessions'>Index</a>"
      end
    else
      session[:user_id] = nil
      render text: "user not found <a href='/sessions'>Index</a>"
    end
    p @user
  end

  def user_exists
    if User.exists?(session[:user_id])
      true
    else
      session[:user_id] = nil
      false
    end
  end

end
