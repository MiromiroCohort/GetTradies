require 'rails_helper'

# feature "Sign up and logout", :type => :feature do
#   before(:each) do
#     prelim_initialization_for_all_tests
#   end
#   after(:each) do
#     destroy_user_and_job
#   end

#   scenario 'user can sign up' do
#     visit new_user_path
#     sign_up
#     click_on 'Sign up'
#       expect(page).to have_content("Update user profile")
#     click_on 'Logout'
#       expect(page).to have_content("user logged out")
#   end
# end # End of sign up and log out feature

feature "Jobs", :type => :feature do
  before(:each) do
    prelim_initialization_for_all_tests
  end

  after(:each) do
    destroy_user_and_job
  end

  scenario 'user visits post a job page' do
    visit '/jobs/new'
    expect(page).to have_content('Please describe your job here')
  end

  scenario 'logged in user can see existing jobs that are listed' do
    visit '/jobs'
    expect(page).to have_content('Quba street')
  end

  scenario 'logged in user can progress a job posting' do
    visit '/jobs/new'
    post_a_job
    expect(page).to have_content('Quba street')
  end

  scenario 'unlogged in user cannot progress a job posting' do
    click_on 'Logout'
    visit '/jobs/new'
    expect(page).to have_content('Quba street')
  end

  scenario 'creating a job increases the number of jobs in database' do
    existing_jobs = Job.all.length
    visit '/jobs/new'
    post_a_job
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


feature "Post jobs", :type => :feature do

  before(:each) do
      prelim_initialization_for_all_tests
    end

    after(:each) do
      destroy_user_and_job
    end

  scenario 'logged in user can open a post job page' do
    visit '/jobs/new'
    expect(page).to have_content("Please describe your job here")
  end

  scenario 'post job page has an Upload photo button' do
    visit new_job_path
    expect(page).to have_content("Title")
  end

end


feature "Show interest", :type => :feature do

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
    expect(tender.job_id).to eq(job.id)
  end

  scenario 'tradie can click on show interest button and will be redirected to his tenders' do
    create_tradie_and_login
    visit jobs_path
    click_on('Show interest')
    expect(page).to have_content('You successfully applied for a job')
  end

  # scenario 'customer can click on "show interest button" and will have message that he should be registered as tradie' do
  #   user1 = User.new
  #   user1.email = "gin2@gmail.com"
  #   user1.password ='qwerty'
  #   user1.save

  #   visit jobs_path
  #     fill_in 'email', with: "gin2@gmail.com"
  #     fill_in 'password', with: 'qwerty'
  #     click_on "Log in"

  #   visit jobs_path
  #     click_link('Show interest')
  #     expect(page).to have_content("You need to be registered as a tradie to apply")
  # end

  #  scenario 'customer can click on "show interest button" and will have message that he should be registered as tradie' do
  #   visit jobs_path
  #   click_link('Show interest')
  #   expect(page).to have_content("You need to be logged in to register interest in a job")
  # end
end # End of show interest feature tests


# feature "See users jobs", :type => :feature do

#  before(:each) do
#     User.destroy_all
#     Job.destroy_all
#     user1=User.new
#     user1.email="gin1@gmail.com"
#     user1.password='qwerty'
#     user1.save
#     user=User.new
#     user.email="gin2@gmail.com"
#     user.password='qwerty'
#     user.save
#     user1.jobs.create location:"Quba street", description:"Dishwasher"
#     user.jobs.create location:"Churchill Drive", description:"Oven"
#   end

#   after(:each) do
#     User.destroy_all
#     Job.destroy_all
#   end

#   scenario 'User can see particular users jobs' do
#     user=User.first
#     visit user_jobs_path(user)
#     expect(page).to have_content("Quba street")
#     expect(page).to have_content("Dishwasher")
#     expect(page).to have_no_content("Churchill")
#     expect(page).to have_no_content("Oven")
#   end

#   scenario 'User can see particular users jobs' do
#     user=User.last
#     visit user_jobs_path(user)
#     expect(page).to have_no_content("Quba street")
#     expect(page).to have_no_content("Dishwasher")
#     expect(page).to have_content("Churchill")
#     expect(page).to have_content("Oven")
#   end
# end # End of see users jobs feature

# feature "Delete own job", :type => :feature do

#  before(:each) do
#     User.destroy_all
#     Job.destroy_all
#     user1=User.new
#     user1.email="gin1@gmail.com"
#     user1.password='qwerty'
#     user1.save
#     user1.jobs.create location:"Quba street", description:"Dishwasher"
#     user1.jobs.create location:"Churchill Drive", description:"Oven"
#   end

#   after(:each) do
#     User.destroy_all
#     Job.destroy_all
#   end

#   scenario 'User can delete his jobs' do
#     visit jobs_path
#       fill_in 'email', with: "gin1@gmail.com"
#       fill_in 'password', with: 'qwerty'
#       click_on "Log in"

#     user=User.last

#     visit user_jobs_path(user)
#       first(:link, "Delete job").click
#       expect(page).to have_no_content("Quba street")
#       expect(page).to have_no_content("Dishwasher")
#       expect(page).to have_content("Churchill")
#       expect(page).to have_content("Oven")
#       expect(page).to have_content("Job deleted")
#   end
# end # End of Delete own job feature
