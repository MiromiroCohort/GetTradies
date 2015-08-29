class Job < ActiveRecord::Base

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: ":styles/get_tradie.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  has_many :tenders
  belongs_to :user
  # has_many :tradies, class_name: "User", through: :tenders
  # , foreign_key: "tradie_id"
  def short_desc
    return description.slice(0,40)
  end

end
