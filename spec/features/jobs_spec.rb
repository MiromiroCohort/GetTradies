require 'rails_helper'

feature "Jobs", :type => :feature do
  scenario 'user can see job description' do
    visit jobs_path

    expect(page).to have_content('Job Description')
  end
  scenario 'user can see show interest button' do
    visit jobs_path

    expect(page).to have_link('Show Interest')
  end

  scenario 'user can see location' do
    visit jobs_path

    expect(page).to have_content('Location')
  end

end
