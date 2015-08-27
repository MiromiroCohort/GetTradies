require 'bcrypt'

class User < ActiveRecord::Base

    attr_accessor :password_confirm

    has_many :jobs
    has_many :tenders
    # has_many :tenders, through: :jobs, foreign_key: "offer_id"

  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
