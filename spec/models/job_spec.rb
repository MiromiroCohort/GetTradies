require 'rails_helper'

RSpec.describe Job, type: :model do
  it 'gets and sets customer_id, tradie_id, location, description,' do
      Job.destroy_all
      job=Job.new
      job.user_id=1
      job.title="Be all you can be"
      job.location="Quba street"
      job.description="Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
      job.save!
      job=Job.first
      expect(job.customer_id).to eq(1)
      expect(job.tradie_id).to eq(2)
      expect(job.location).to eq("Quba street")
      expect(job.description).to eq("Dishwasher")
  end


end




