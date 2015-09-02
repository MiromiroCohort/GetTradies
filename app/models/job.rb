class Job < ActiveRecord::Base

  scope :search, lambda{ |query| where([ "title LIKE ?", "%#{query}%"]) }

  has_attached_file :image, styles: { medium: "800x800>", thumb: "300x300>" }, default_url: ":styles/get_tradie.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates_attachment_size :image, less_than: 2.megabytes

  has_many :tenders
  belongs_to :user

  def short_desc
    return description.truncate(40, separator: ' ')
  end
end
