require 'rails_helper'

RSpec.describe Job, type: :model do
  it 'gets and sets customer_id, tradie_id, location, description,' do
      Job.destroy_all
      job=Job.new
      job.customer_id=1
      job.tradie_id=2
      job.location="Quba street"
      job.description="Dishwasher"
      job.save
      job=Job.first
      expect(job.customer_id).to eq(1)
      expect(job.tradie_id).to eq(2)
      expect(job.location).to eq("Quba street")
      expect(job.description).to eq("Dishwasher")
  end

  scenario 'user visits post a job page' do
    visit new_job_path

    expect(page).to have_selector('form')
  end

end
