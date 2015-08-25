class ProfilesController < ApplicationController

  def new
  end

  def create
    # @user = User.find_by_id(cookies[:session_id])
    # @id = @user.id
    @profile = Profile.create(profile_params)
    render text: "Success"
  end


    private

  def profile_params
    # Same as using "params[:profile]", except that it:
    # - raises an error if :profilegi is not present
    # - allows listed attributes to be mass-assigned
    params.require(:profile).permit(:given_name, :family_name, :phone_number, :address, :user_id)
  end

end