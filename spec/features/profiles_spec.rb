require 'rails_helper'

RSpec.feature "Profiles", type: :feature do

  scenario 'they see the form on the page' do
    visit edit_user_path
    expect(page).to have_selector('form')
  end

  scenario 'they can complete the form and save it' do
   pending "that's Michael and Lani test"
    visit new_profile_path
    fill_in 'username', with: "Johnny"
    fill_in 'given_name', with: "John"
    fill_in 'family_name', with: "Smith"
    fill_in 'email', with: "John.Smith@aol.com"
    fill_in 'phone-number', with: "01234567"
    fill_in 'address', with: "13 Waindale Close"
    fill_in 'description', with: "13 Waindale Close"


    click_button 'Save'
  end

end
