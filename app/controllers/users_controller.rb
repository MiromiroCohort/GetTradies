class UsersController < ApplicationController
  def new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user
  end


  private

  def user_params
    # Same as using "params[:user]", except that it:
    # - raises an error if :user is not present
    # - allows listed attributes to be mass-assigned
    params.require(:user).permit(:email, :password, :password_confirm)
  end

end # End of class
