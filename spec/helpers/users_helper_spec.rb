require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the UsersHelper. For example:
#
# describe UsersHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe UsersHelper, type: :helper do
  pending "add some examples to (or delete) #{__FILE__}"
end


def create_user1_and_job
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

def create_tradie
  user2 = User.new
  user2.email="gin2@gmail.com"
  user2.password='qwerty'
  user2.profession="Builder"
  user2.save
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

# def sign_up
#   visit 'users/new'
#   within_fieldset("signup") do
#     fill_in 'email', with: 'gin1@gmail.com'
#     fill_in 'password', with: 'mike'
#     fill_in 'password_confirm', with: 'mike'
#     click_on 'Sign up'
#   end
#   puts User.new
# end

def prelim_initialization_for_all_tests
  create_user1_and_job
  login_user1
end

def destroy_user_and_job
  User.destroy_all
  Job.destroy_all
end

def post_a_job
  fill_in 'job[title]', with: 'title'
  fill_in 'job[description]', with: 'jobby job'
  fill_in 'job[location]', with: 'placy place'
  click_on 'Post job'
end

def create_tradie_and_login
  click_on 'Logout'
  create_tradie
  login_tradie
  visit '/jobs'
end

