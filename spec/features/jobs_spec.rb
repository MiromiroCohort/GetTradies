require 'rails_helper'

feature "jobs", :type => :feature do
  before(:each) do
    prelim_initialization_for_all_tests
  end

  after(:each) do
    destroy_user_and_job
  end

  scenario 'user visits post a job page' do
    visit new_job_path
    expect(page).to have_content('Please describe your job here')
  end

  scenario 'logged in user can see existing jobs that are listed' do
    visit jobs_path
    expect(page).to have_content('Quba street')
  end

  scenario 'logged in user can progress a job posting' do
    visit new_job_path
    post_a_job
    expect(page).to have_content('Quba street')
  end

  scenario 'unlogged in user cannot progress a job posting' do
    click_on 'Logout'
    visit new_job_path
    expect(page).to have_content('Quba street')
  end

  scenario 'creating a job increases the number of jobs in database' do
    existing_jobs = Job.all.length
    visit new_job_path
    post_a_job
    new_jobs = Job.all.length
    expect(new_jobs).to be > existing_jobs
  end

  scenario 'user can see job description' do
    visit jobs_path
    expect(page).to have_content('new job')
  end

  scenario 'user can see location' do
    visit jobs_path
    expect(page).to have_content('Location')
  end

  scenario 'user can see location from database' do
    visit jobs_path
    expect(page).to have_content('Location: Quba street')
  end

  scenario 'user can click on more info and be redirected to full description page' do
    job = Job.first
    visit jobs_path
    click_on 'More info'
    expect(current_path).to eq('/jobs/'+job.id.to_s)
  end

  scenario 'user can click on description and get to page with full description location' do
    job = Job.first
    visit jobs_path
    click_on 'More info'
    expect(page).to have_content('Location: Quba street')
  end

  scenario 'user can click on description and get full description' do
    job = Job.first
    visit jobs_path
    click_on 'More info'
    expect(page).to have_content("Ut enim ad minim veniam")
  end
end # End of Jobs feature


feature "post a job", :type => :feature do

  before(:each) do
      prelim_initialization_for_all_tests
    end

  after(:each) do
    destroy_user_and_job
  end

  scenario 'logged in user can open a post job page' do
    visit new_job_path
    expect(page).to have_content("Please describe your job here")
  end

  scenario 'post job page has an Upload photo button' do
    visit new_job_path
    expect(page).to have_content("Title")
  end
end # End of post job feature


feature "show interest in a job", :type => :feature do

  before(:each) do
    prelim_initialization_for_all_tests
  end

  after(:each) do
    destroy_user_and_job
  end

  scenario 'tradie can click on show interest button and will have that job applied' do
    tender=Tender.last
    job=Job.last
    create_tradie_and_login
    click_on('Show interest')
    expect(page).to have_content("My jobs")
  end

  scenario 'tradie can click on show interest button and will be redirected to his tenders' do
    create_tradie_and_login
    visit jobs_path
    click_on('Show interest')
    expect(page).to have_content('You successfully applied for a job')
  end

  scenario 'user who is not a tradie can click on "Show interest" button' do
    click_on 'Logout'
    visit jobs_path
    create_user3
    login_user3
    visit jobs_path
    click_link('Show interest')
    expect(page).to have_content("You need to be registered as a tradie to apply")
  end
end # End of show interest feature tests


feature "see users jobs", :type => :feature do

  before(:each) do
      prelim_initialization_for_all_tests
  end

  after(:each) do
    destroy_user_and_job
  end

  scenario 'user can see particular users jobs' do
    click_on 'Logout'
    create_user3
    login_user3
    visit jobs_path
    click_link 'More jobs from this user'
    expect(page).to have_content("Quba street")
    expect(page).to have_content("Lorem ipsum dolor")
  end
end # End of see users jobs feature

feature "delete a job", :type => :feature do

  before(:each) do
      prelim_initialization_for_all_tests
  end

  after(:each) do
    destroy_user_and_job
  end

  scenario 'user can delete their jobs' do
    click_on 'My jobs'
    click_on 'Delete job'
    expect(page).to have_no_content("Quba street")
    expect(page).to have_no_content("Dishwasher")
    expect(page).to have_content("Job deleted")
  end
end # End of Delete own job feature
