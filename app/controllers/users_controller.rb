
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

end
