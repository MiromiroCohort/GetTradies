class SessionsController < ApplicationController

  def new
    # render text: "good work old bot"
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user
      if @user.password == params[:password]
        cookies[:session_id] = { :value => @user.id, :expires => Time.now + 3600}
        render text: "hello owner of #{params[:email]}. you are now logged in. cookie = #{cookies[:session_id]}"
      else
        session.clear
        render text: "password incorrect"
      end
    else
      session.clear
      render text: "user not found"
    end
  end

end
