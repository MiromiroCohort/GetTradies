require 'bcrypt'

class User < ActiveRecord::Base
  has_many :jobs
  has_many :tenders
  attr_accessor :password_confirm

   has_attached_file :image, styles: { medium: "800x8git00>", thumb: "300x300>" }, default_url: ":styles/get_tradie.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates_attachment_size :image, less_than: 2.megabytes

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
