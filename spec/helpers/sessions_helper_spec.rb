require 'rails_helper'

RSpec.feature "Signups", type: :feature do

  scenario "users see signup page" do
    visit new_user_path

    expect(page).to have_selector('form')
  end

end

