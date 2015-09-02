require 'rails_helper'

RSpec.feature "Unregistered user access to features", type: :feature do

  scenario 'user can see "More info", "Show interest", "More jobs by this user" links' do
    create_user1_and_job
    visit jobs_path
    expect(page).to have_link('More info')
    expect(page).to have_link('Show interest')
    expect(page).to have_link('More jobs from this user')
  end

  scenario 'user can see "Login" button and "Or sign up" link' do
    create_user1_and_job
    visit jobs_path
    expect(page).to have_button('Log in')
    expect(page).to have_link('Or sign up')
  end

  scenario 'user can see more info of a job' do
    create_user1_and_job
    visit jobs_path
    click_on 'More info'
    expect(page).to have_content('Quba street')
  end

  scenario 'user cannot show interest in a job on full job description page' do
    create_user1_and_job
    visit jobs_path
    click_on 'More info'
    click_on 'Show Interest'
    expect(page).to have_content('You need to be logged in to register interest in a job')
  end

   scenario 'user cannot show interest in a job on homepage' do
    create_user1_and_job
    visit jobs_path
    click_on 'Show interest'
    expect(page).to have_content('You need to be logged in to register interest in a job')
  end

  scenario 'user can search jobs on home page' do
    create_user1_and_job
    visit jobs_path
    fill_in 'search', with: 'new job'
    expect(page).to have_content('Quba street')
  end
end