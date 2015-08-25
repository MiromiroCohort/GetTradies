class UsersController < ApplicationController
  def new
  end

  def create

    if !User.find_by_email(params[:email])
      if params[:password] == params[:password_confirm]
        @user = User.create(email: params[:email], password: params[:password])
        render text: "new user #{@user.email}"
      else
        render text: "Passwords do not match"
      end
    else
      render text: "email already assigned to account. Please <a href='sessions/new'>log in.</a>"
    end
  end

  # def edit
  #   @user = User.find(params[:id])
  # end

  # def update
  #   # Find an existing object using form parameters
  #   @user = User.find(params[:id])
  #   # Update the object
  #   # if @user.update_attributes(subject params)
  #     # If update succeeds, redirect to the where we want them to go
  #     # flash[:notice] = "Thank you '#{@user.name}' your profile was updated successfully"
  #     # redirect_to(:action => '??', :id => @user.id)
  #   # else
  #       # If update fails, redisplay the form so user can fix problems
  #       # render('edit')
  #   # end
  # end



  private

  def subject_params
    # Same as using "params[:user]", except that it:
    # - raises an error if :user is not present
    # - allows listed attributes to be mass-assigned
    params.require(:user).permit(:name, :phone_number, :address)
  end

end # End of class
