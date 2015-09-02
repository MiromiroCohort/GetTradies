require 'rails_helper'

feature "My jobs", :type => :feature do
  before(:each) do
    prelim_initialization_for_all_tests
  end

  after(:each) do
    destroy_user_and_job
  end

  scenario 'user can see their listed jobs' do
    click_on 'My jobs'
    expect(page).to have_content('Quba street')
  end
end