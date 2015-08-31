require 'rails_helper'
feature "Jobs", :type => :feature do
  before(:each) do
    User.destroy_all
    Job.destroy_all
    user1 = User.new
    user1.email="gin1@gmail.com"
    user1.password='qwerty'
    user1.save
    job = Job.new
    job.user = user1
    job.location="Quba street"
    job.description="Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    job.save!
  end
  after(:each) do
    User.destroy_all
    Job.destroy_all
  end

  scenario 'user visits post a job page' do
    visit '/jobs/new'

    expect(page).to have_selector('form')
  end

  scenario 'user can see show interest button' do
    visit jobs_path

    expect(page).to have_link('Show interest')
  end

  scenario 'logged in user can progress a job posting' do
    user1 = User.new
    user1.email = "gin1@gmail.com"
    user1.password ='qwerty'
    user1.profession ='tradie'
    user1.save
    visit jobs_path
      fill_in 'email', with: "gin1@gmail.com"
      fill_in 'password', with: 'qwerty'
      click_on "Log in"

    visit '/jobs/new'
      fill_in 'job[description]', with: 'jobby job'
      fill_in 'job[location]', with: 'placy place'
      click_on 'Post job'

    expect(page).to have_content('jobby job')
  end

  scenario 'unlogged in user cannot progress a job posting' do
    visit '/jobs/new'
      fill_in 'job[description]', with: 'jobby job'
      fill_in 'job[location]', with: 'placy place'
      click_on 'Post job'
    expect(page).to have_content('log-in')
  end

  scenario 'creating a job increases the number of jobs in database' do
    existing_jobs = Job.all.length

    user1 = User.new
    user1.email = "gin1@gmail.com"
    user1.password ='qwerty'
    user1.profession ='tradie'
    user1.save
    visit jobs_path
      fill_in 'email', with: "gin1@gmail.com"
      fill_in 'password', with: 'qwerty'
      click_on "Log in"

    visit '/jobs/new'
      fill_in 'job[description]', with: 'jobby job'
      fill_in 'job[location]', with: 'placy place'
      click_on 'Post job'

    new_jobs = Job.all.length

    expect(new_jobs).to be > existing_jobs
  end

  scenario 'user can see job description' do
    visit jobs_path

    expect(page).to have_content('Job Description')
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
end


feature "Post jobs", :type => :feature do

  scenario 'logged user can open a post job page' do
    visit new_job_path
    expect(page).to have_content("Please describe your job here")
  end

  scenario 'post job page has an Upload photo button' do
    visit new_job_path
    expect(page).to have_content("Title")
  end

end


feature "Show interest", :type => :feature do
  before(:each) do
    User.destroy_all
    Job.destroy_all
    user1 = User.new
    user1.email="gin1@gmail.com"
    user1.password='qwerty'
    user1.save
    job = Job.new
    job.user = user1
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
    user1 = User.new
    user1.email = "gin2@gmail.com"
    user1.password ='qwerty'
    user1.profession ='tradie'
    user1.save

    visit jobs_path
      fill_in 'email', with: "gin2@gmail.com"
      fill_in 'password', with: 'qwerty'
      click_on "Log in"

    visit jobs_path
      click_on('Show interest')

      tender=Tender.last
      job=Job.last
      expect(page).to have_content("My jobs")
      expect(tender.job_id).to eq(job.id)
      expect(tender.user_id).to eq(user1.id)
  end

  scenario 'tradie can click on show interest button and will be redirected to his tenders' do
    user1 = User.new
    user1.email = "gin2@gmail.com"
    user1.password ='qwerty'
    user1.profession ='tradie'
    user1.save

    visit jobs_path
      fill_in 'email', with: "gin2@gmail.com"
      fill_in 'password', with: 'qwerty'
      click_on "Log in"

    visit jobs_path
      click_on('Show interest')
      expect(current_path).to eq(user_tenders_path(user1))
  end

  scenario 'customer can click on "show interest button" and will have message that he should be registered as tradie' do
    user1 = User.new
    user1.email = "gin2@gmail.com"
    user1.password ='qwerty'
    user1.save

    visit jobs_path
      fill_in 'email', with: "gin2@gmail.com"
      fill_in 'password', with: 'qwerty'
      click_on "Log in"

    visit jobs_path
      click_link('Show interest')
      expect(page).to have_content("You need to be registered as a tradie to apply")
  end

   scenario 'customer can click on "show interest button" and will have message that he should be registered as tradie' do
    visit jobs_path
    click_link('Show interest')
    expect(page).to have_content("You should be logged in")
  end
end # End of show interest feature tests


feature "See users jobs", :type => :feature do

 before(:each) do
    User.destroy_all
    Job.destroy_all
    user1=User.new
    user1.email="gin1@gmail.com"
    user1.password='qwerty'
    user1.save
    user=User.new
    user.email="gin2@gmail.com"
    user.password='qwerty'
    user.save
    user1.jobs.create location:"Quba street", description:"Dishwasher"
    user.jobs.create location:"Churchill Drive", description:"Oven"
  end

  after(:each) do
    User.destroy_all
    Job.destroy_all
  end

  scenario 'User can see particular users jobs' do
    user=User.first
    visit user_jobs_path(user)
    expect(page).to have_content("Quba street")
    expect(page).to have_content("Dishwasher")
    expect(page).to have_no_content("Churchill")
    expect(page).to have_no_content("Oven")
  end

  scenario 'User can see particular users jobs' do
    user=User.last
    visit user_jobs_path(user)
    expect(page).to have_no_content("Quba street")
    expect(page).to have_no_content("Dishwasher")
    expect(page).to have_content("Churchill")
    expect(page).to have_content("Oven")
  end
end # End of see users jobs feature

feature "Delete own job", :type => :feature do

 before(:each) do
    User.destroy_all
    Job.destroy_all
    user1=User.new
    user1.email="gin1@gmail.com"
    user1.password='qwerty'
    user1.save
    user1.jobs.create location:"Quba street", description:"Dishwasher"
    user1.jobs.create location:"Churchill Drive", description:"Oven"
  end

  after(:each) do
    User.destroy_all
    Job.destroy_all
  end

  scenario 'User can delete his jobs' do
    visit jobs_path
      fill_in 'email', with: "gin1@gmail.com"
      fill_in 'password', with: 'qwerty'
      click_on "Log in"

    user=User.last

    visit user_jobs_path(user)
      first(:link, "Delete job").click
      expect(page).to have_no_content("Quba street")
      expect(page).to have_no_content("Dishwasher")
      expect(page).to have_content("Churchill")
      expect(page).to have_content("Oven")
      expect(page).to have_content("Job deleted")
  end
end # End of Delete own job feature
