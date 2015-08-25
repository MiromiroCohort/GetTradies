class SessionsController < ApplicationController

  def new
    # render text: "good work old bot"
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user
      if params[:password] == @user.password
        cookies[:sessionemail] = { :value => params[:email], :expires => Time.now + 3600}
        render text: "hello owner of #{params[:email]}. you are now logged in. cookie = #{cookies[:sessionemail]}"
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
