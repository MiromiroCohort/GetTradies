
class UsersController < ApplicationController

  def new
  end

  def create
    if !User.find_by_email(user_params[:email])
       if user_params[:password] == user_params[:password_confirm]
        @user = User.new(user_signup_params)
        @user.save
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


  private

  def user_signup_params
    params.permit(:email, :password, :password_confirm)
  end

  def user_update_params
  end

end
