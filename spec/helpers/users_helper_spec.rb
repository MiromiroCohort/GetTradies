require 'rails_helper'

def create_user1_and_job
  user1 = User.new
  user1.email = "gin1@gmail.com"
  user1.password ='qwerty'
  user1.save
  job = Job.new
  job.user = user1
  job.title = "new job"
  job.location = "Quba street"
  job.description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
  job.save!
end

def create_tradie
  user2 = User.new
  user2.email="gin2@gmail.com"
  user2.password='qwerty'
  user2.profession="Builder"
  user2.save
end

def create_user3
  user1 = User.new
  user1.email="gin3@gmail.com"
  user1.password='qwerty'
  user1.save
end



def login_user1
  visit '/jobs'
  within_fieldset("login") do
    fill_in 'email', with: 'gin1@gmail.com'
    fill_in 'password', with: 'qwerty'
    click_on 'Log in'
  end
end

def login_tradie
  visit '/jobs'
  within_fieldset("login") do
    fill_in 'email', with: 'gin2@gmail.com'
    fill_in 'password', with: 'qwerty'
    click_on 'Log in'
  end
end

def login_user3
  visit '/jobs'
  within_fieldset("login") do
    fill_in 'email', with: 'gin3@gmail.com'
    fill_in 'password', with: 'qwerty'
    click_on 'Log in'
  end
end

def prelim_initialization_for_all_tests
  create_user1_and_job
  login_user1
end

def destroy_user_and_job
  User.destroy_all
  Job.destroy_all
end

def post_a_job
  page.attach_file('job[image]', Rails.root + 'spec/Fixtures/cat.jpg')
  fill_in 'job[title]', with: 'title'
  fill_in 'job[description]', with: 'jobby job'
  select 'Te Aro', from: 'job[location]'
  click_on 'Post job'
end

def create_tradie_and_login
  click_on 'Logout'
  create_tradie
  login_tradie
  visit '/jobs'
end

