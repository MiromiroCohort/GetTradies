class Job < ActiveRecord::Base
  def short_desc
    return description.slice(0,40)
  end
end
