class UsersController < ApplicationController

  def new
  end

  def create
    if !User.find_by_email(user_signup_params[:email])
       if user_signup_params[:password] == user_signup_params[:password_confirm]
        @user = User.new(user_signup_params)
        @user.save
        session[:user_id] = @user.id
        redirect_to edit_user_path(@user)
       else
        redirect_to "/"
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
    @current_user = User.find_by_id(session[:user_id])
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

  def edit
    @user = User.find(session[:user_id])
  end

  def update
    @current_user = User.find_by_id(session[:user_id])
    if @user = User.find(params[:id])
      @id = @user.id.to_s
      @user.update_attributes(user_update_params)
      flash[:notice] = "Your profile has been successfully updated"
      # redirect_to(:action => 'show', :id => @user.id)
      redirect_to '/users/'+ @id + '/jobs/new'
    else
      render('edit')
    end

  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to '/users'
  end


  private

  def user_signup_params
    params.permit(:email, :password, :password_confirm)
  end

  def user_update_params
    params.require(:user).permit(:username, :given_name, :family_name, :email, :address, :phone_number, :profession, :description)
  end

end
