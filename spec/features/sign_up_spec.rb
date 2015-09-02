require 'rails_helper'

feature "Sign up", :type => :feature do

  scenario 'user can sign up' do
    visit new_job_path
    click_on 'Or sign up'
    within_fieldset('signup') do
      fill_in 'email', with: 'mspeight2@hotmail.com'
      fill_in 'password', with: 'mike'
      fill_in 'password_confirm', with: 'mike'
    end
    click_on 'Sign up'
    expect(page).to have_content('Update user profile')
  end

  scenario 'user can log out' do
    prelim_initialization_for_all_tests
    click_on 'Logout'
    expect(page).to have_content('user logged out')
  end
end
