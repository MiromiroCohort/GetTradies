class Job < ActiveRecord::Base

  has_many :tenders
  belongs_to :user
  # has_many :tradies, class_name: "User", through: :tenders
  # , foreign_key: "tradie_id"
  def short_desc
    return description.slice(0,40)
  end

end
