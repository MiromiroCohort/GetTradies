require 'rails_helper'

RSpec.feature "Profiles", type: :feature do

  # user can see the sign up page
  scenario 'user can sigunp to create a session' do
    visit new_session_path
    expect(page).to have_selector('form')
  end

  # user fills out sign up form
  scenario 'user can complete the sign up form and save it' do
    visit new_user_path

    fill_in 'user[email]', with: "mspeight2@hotmail.com"
    fill_in 'user[password]', with: "Mikemike"
    fill_in 'user[password_confirm]', with: "Mikemike"

    click_button 'sign-up'
  end

  #   # user to see form selector on jobs/index page
  #   expect(page).to have_selector('form')
  # end

  # # user can see list of all jobs that are currently live on the site jobs/index page
  # scenario 'user can see all of the current jobs on the site' do
  #   visit jobs_path
  #   expect(page).to have_selector('form')
  # end


  # user can see the blank profile page
  scenario 'they can see the blank profile page' do
    visit new_profile_path
    expect(page).to have_selector('form')
  end

  #
  scenario 'user can complete the profile form and save it' do
    visit new_profile_path

    fill_in 'profile[given_name]', with: "John"
    fill_in 'profile[family_name]', with: "Smith"
    fill_in 'profile[phone_number]', with: "01234567"
    fill_in 'profile[address]', with: "13 Waindale Close"

    click_button 'Save'
    expect(page).to have_content 'Success'
  end


end
