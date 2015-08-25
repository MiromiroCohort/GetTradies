require 'rails_helper'

RSpec.feature "Profiles", type: :feature do

  scenario 'they see the form on the page' do
    visit new_profile_path
    expect(page).to have_selector('form')
  end

  scenario 'they can complete the form and save it' do
    visit new_profile_path
    fill_in 'name', with: "John Smith"
    fill_in 'phone-number', with: "01234567"
    fill_in 'address', with: "13 Waindale Close"

    click_button 'Save'
  end

end
