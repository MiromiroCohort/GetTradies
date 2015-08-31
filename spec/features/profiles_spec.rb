require 'rails_helper'

RSpec.feature "Profiles", type: :feature do

  scenario 'they see the form on the page' do
    user1 = User.new
    user1.email = "gin1@gmail.com"
    user1.password ='qwerty'
    user1.profession ='tradie'
    user1.id = 1
    user1.save

    visit jobs_path
      fill_in 'email', with: "gin1@gmail.com"
      fill_in 'password', with: 'qwerty'
      click_on "Log in"

    visit 'users/' + user1.id.to_s + '/edit'
    expect(page).to have_selector('form')
  end

  scenario 'they can complete the form and save it' do
    user1 = User.new
    user1.email = "gin1@gmail.com"
    user1.password ='qwerty'
    user1.profession ='tradie'
    user1.id = 1
    user1.save

    visit jobs_path
      fill_in 'email', with: "gin1@gmail.com"
      fill_in 'password', with: 'qwerty'
      click_on "Log in"

    visit 'users/' + user1.id.to_s + '/edit'
      fill_in 'user[username]', with: "Johnny"
      fill_in 'user[given_name]', with: "John"
      fill_in 'user[family_name]', with: "Smith"
      fill_in 'user[email]', with: "John.Smith@aol.com"
      fill_in 'user[phone_number]', with: "01234567"
      fill_in 'user[address]', with: "13 Waindale Close"
      fill_in 'user[description]', with: "13 Waindale Close"

    click_button 'Update User'
  end

end
