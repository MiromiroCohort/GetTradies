require 'rails_helper'

RSpec.feature "Profiles", type: :feature do

  scenario 'they can see the blank profile page' do
    visit new_profile_path
    expect(page).to have_selector('form')
  end

  scenario 'they can complete the form and save it' do

    visit new_profile_path

    fill_in 'profile[given_name]', with: "John"
    fill_in 'profile[family_name]', with: "Smith"
    fill_in 'profile[phone_number]', with: "01234567"
    fill_in 'profile[address]', with: "13 Waindale Close"

    click_button 'Save'
    expect(page).to have_content 'Success'
  end

  # scenario 'their details are saved to the database when the form is submitted' do
  #   visit
  # end

end
