require 'rails_helper'

RSpec.feature "Tenders", type: :feature do
  before(:each) do
    create_tenders
  end

  after(:each) do
    delete_db_enteries
  end

  scenario 'tradie can see a list of his tenders' do
    user = User.first
    visit user_tenders_path(user)
    expect(page).to have_content("Churchill Drive")
    expect(page).to have_content("Oven")
  end

  scenario 'tradie cannot see a contact information for unaccepted tender' do
    user = User.first
    visit user_tenders_path(user)
    expect(page).to have_no_content("gin2@gmail.com")
  end

  scenario 'tradie can see a contact information for customer accepted tender' do
    visit jobs_path
      fill_in 'email', with: "gin1@gmail.com"
      fill_in 'password', with: 'qwerty'
      click_on "Log in"
    user = User.first
    tender = Tender.last
    tender.accepted = true
    tender.save

    visit user_tenders_path(user)
    expect(page).to have_content("gin2@gmail.com")

  end

end
