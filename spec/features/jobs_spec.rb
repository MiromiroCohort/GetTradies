require 'rails_helper'
feature "Jobs", :type => :feature do
  before(:each) do
    Job.destroy_all
    job=Job.new
    job.customer_id=1
    job.tradie_id=2
    job.location="Quba street"
    job.description="Dishwasher"
    job.save
  end
  after(:each) do
    Job.destroy_all
  end
  scenario 'user can see job description' do
    visit jobs_path

    expect(page).to have_content('Job Description')
  end
  scenario 'user can see show interest button' do
    visit jobs_path

    expect(page).to have_link('Show Interest')
  end

  scenario 'user can see location' do
    visit jobs_path

    expect(page).to have_content('Location')
  end
  scenario 'user can see location from database' do
    visit jobs_path
    expect(page).to have_content('Location: Quba street')
  end
  scenario 'user can see job description' do
    visit jobs_path

    expect(page).to have_content('Dishwasher')
  end

end
