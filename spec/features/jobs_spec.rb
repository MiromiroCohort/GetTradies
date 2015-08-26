require 'rails_helper'
feature "Jobs", :type => :feature do
  before(:each) do
    User.destroy_all
    Job.destroy_all
    job=Job.new
    job.user_id=1
    # job.tradie_id=2
    job.location="Quba street"
    job.description="Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    job.save
  end
  after(:each) do
    User.destroy_all
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
    desc = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    short_desc=desc.slice(0,40)
    expect(page).to have_content(short_desc)
    expect(page).to have_no_content("Ut enim ad minim veniam")
  end
  scenario 'user can click on description and be redirected to full description page' do
    job = Job.first
    visit jobs_path
    click_link('job_'+job.id.to_s)
    expect(current_path).to eq('/jobs/'+job.id.to_s)
  end
  scenario 'user can click on description and get to page with full description location' do
    job = Job.first
    visit jobs_path
    click_link('job_'+job.id.to_s)
    expect(page).to have_content('Location: Quba street')
  end
  scenario 'user can click on description and get full description' do
    job = Job.first
    visit jobs_path
    click_link('job_'+job.id.to_s)
    expect(page).to have_content("Ut enim ad minim veniam")
  end


end
feature "Post jobs", :type => :feature do
  scenario 'logged user can open a post job page' do
    # right now - all users
    visit new_job_path
    expect(page).to have_content("Please describe your job here")
  end
  scenario 'post job page has an Upload photo button' do
    # right now - all users
    visit new_job_path
    expect(page).to have_content("Upload photo")
  end

end

feature "Show interest", :type => :feature do
  before(:each) do
    User.destroy_all
    Job.destroy_all
    job=Job.new
    job.user_id=1
    # job.tradie_id=2
    job.location="Quba street"
    job.description="Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    job.save
  end
  after(:each) do
    User.destroy_all
    Job.destroy_all
  end
  scenario 'tradie can click on show interest button and will have that job applied' do
    visit new_user_path
    fill_in 'email', with: "gin3002@mail.com"
    fill_in 'password', with: "testPassword"
    fill_in 'password-confirm', with: "testPassword"
    click_on 'Submit'
    visit new_session_path
    fill_in 'email', with: "gin3002@mail.com"
    fill_in 'password', with: "testPassword"
    click_button 'Submit'
    user = User.first
    user.profession = "tradie"
    user.save
    visit jobs_path
    click_on('Show Interest')
    tender=Tender.last
    job=Job.last
    expect(page).to have_content("My jobs")
    expect(tender.job_id).to eq(job.id)
    expect(tender.user_id).to eq(user.id)
  end
   scenario 'tradie can click on show interest button and will be redirected to his tenders' do
    visit new_user_path
    fill_in 'email', with: "gin3002@mail.com"
    fill_in 'password', with: "testPassword"
    fill_in 'password-confirm', with: "testPassword"
    click_on 'Submit'
    visit new_session_path
    fill_in 'email', with: "gin3002@mail.com"
    fill_in 'password', with: "testPassword"
    click_button 'Submit'
    user = User.first
    user.profession = "tradie"
    user.save
    visit jobs_path
    click_on('Show Interest')
    expect(current_path).to eq(user_tenders_path(user))
  end

  scenario 'customer can click on "show interest button" and will have message that he should be registered as tradie' do
    visit new_user_path
    fill_in 'email', with: "gin3002@mail.com"
    fill_in 'password', with: "testPassword"
    fill_in 'password-confirm', with: "testPassword"
    click_on 'Submit'
    visit new_session_path
    fill_in 'email', with: "gin3002@mail.com"
    fill_in 'password', with: "testPassword"
    click_button 'Submit'
    visit jobs_path
    click_link('Show Interest')
    expect(page).to have_content("You should be registered as a tradie")
  end
   scenario 'customer can click on "show interest button" and will have message that he should be registered as tradie' do
    visit jobs_path
    click_link('Show Interest')
    expect(page).to have_content("You should be logged in")
  end
end
