require 'bcrypt'

class User < ActiveRecord::Base

   has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: ":styles/get_tradie.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

    attr_accessor :password_confirm

    has_many :jobs
    has_many :tenders
    # has_many :tenders, through: :jobs, foreign_key: "offer_id"

    def rating
      accepted_jobs = Tender.where(user_id: self.id, accepted: true)
      completed_jobs = []
      accepted_jobs.each { |job| completed_jobs << job if !(job.rating == nil) }
      total = 0
      completed_jobs.each { |job| total += job.rating }
      return "No Ratings Yet" if completed_jobs.length == 0
      return total/completed_jobs.length
    end

  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
