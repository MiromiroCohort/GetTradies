class Profile < ActiveRecord::Base

  attr_accessor :given_name, :family_name, :phone_number, :address, :user_id

end