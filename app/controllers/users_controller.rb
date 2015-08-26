
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

  def index
    @users = User.all
  end

  def show
    # @user = User.find(session[:user_id])
    if params[:id] != "show"
      if User.exists?(params[:id])
        @user = User.find(params[:id])
      else
        redirect_to "/"
      end
    else
      @user = User.find(session[:user_id])
    end
  end

end
