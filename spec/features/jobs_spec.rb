require 'rails_helper'

feature "Jobs", :type => :feature do
  scenario 'user can see job description' do
    visit jobs_path

    expect(page).to have_content('Job Description')
  end
end
