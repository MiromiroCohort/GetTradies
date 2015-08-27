require 'rails_helper'

RSpec.feature "Tenders", type: :feature do
 before(:each) do
    User.destroy_all
    Job.destroy_all
    Tender.destroy_all
    user1 = User.new
    user1.email = "gin1@gmail.com"
    user1.password ='qwerty'
    user1.profession ='tradie'
    user1.save
    user = User.new
    user.email = "gin2@gmail.com"
    user.password = 'qwerty'
    user.profession = 'tradie'
    user.save
    user1.jobs.create location:"Quba street", description:"Dishwasher"
    job = user.jobs.create location:"Churchill Drive", description:"Oven"
    job.tenders.create user:user1
    # User.create(email: "email@email", password_hash: "pw")
  end
  after(:each) do
    User.destroy_all
    Job.destroy_all
    Tender.destroy_all
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
    within_fieldset("login") do
      fill_in 'email', with: "gin1@gmail.com"
      fill_in 'password', with: 'qwerty'
      # fill_in second 'password-confirm', with: "testPassword"
      click_on "Log in"
    end
    user = User.first
    tender = Tender.last
    tender.accepted = true
    tender.save
    visit user_tenders_path(user)
    expect(page).to have_content("gin2@gmail.com")

  end

end
