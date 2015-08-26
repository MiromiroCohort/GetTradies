class ProfilesController < ApplicationController

  def new
  end

  def create
    puts params
    # @user = User.find(params[:session_id])
    # puts @user
    # puts "Mike"
    # @id = 1
    # puts @id
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