class UsersController < ApplicationController

  def new
  end

  def create
    if !User.find_by_email(params[:email])
      if params[:password] == params[:password_confirm]
        @user = User.new(email: params[:email])
        @user.password = params[:password]
        @user.save!
        session[:user_id] = @user.id
        render text: "new user #{@user.email}"
      else
        render text: "Passwords do not match"
      end
    else
      render text: "email already assigned to account. Please <a href='sessions/new'>log in.</a>"
    end
  end

  def edit
    @user = User.find(session[:user_id])
  end

  def update
    @user = User.find(session[:user_id])
    if @user.update_attributes(params)
      if @user.save
        redirect_to(:action => '')
      end
    end
  end

end
