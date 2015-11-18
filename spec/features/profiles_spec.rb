require 'rails_helper'

RSpec.feature "Profiles", type: :feature do
  before(:each) do
    prelim_initialization_for_all_tests
  end

  after(:each) do
    destroy_user_and_job
  end

  scenario 'they see the form on the page' do
    click_on 'My profile'
    expect(page).to have_selector('form')
  end

  scenario 'they can complete the form and save it' do
    fill_in_user_profile
    click_button 'Update User'
    expect(page).to have_content('Your profile has been successfully updated')
  end

end
