class SessionsController < ApplicationController

  def new
    # render text: "good work old bot"
  end

  def index
    if User.exists?(cookies[:session_id])
      render text: "session id = #{cookies[:session_id]}"
    else
      cookies[:session_id] = nil
      render text: "no user session"
    end
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user
      if @user.password == params[:password]
        cookies[:session_id] = { :value => @user.id, :expires => Time.now + 3600}
        render text: "hello owner of #{params[:email]}. you are now logged in. cookie = #{cookies[:session_id]}  <br> Users exists = #{user_exists}"
      else
        cookies[:session_id] = nil
        render text: "password incorrect <a href='/sessions'>Index</a>"
      end
    else
      cookies[:session_id] = nil
      render text: "user not found <a href='/sessions'>Index</a>"
    end
  end

  def user_exists
    if User.exists?(cookies[:session_id])
      true
    else
      cookies[:session_id] = nil
      false
    end
  end

end
