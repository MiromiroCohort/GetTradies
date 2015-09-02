require 'rails_helper'

def fill_in_user_profile
  click_on 'My profile'
  click_on 'Edit profile'
  page.attach_file('user[image]', Rails.root + 'spec/Fixtures/cat.jpg')
  fill_in 'user[username]', with: "Johnny"
  fill_in 'user[given_name]', with: "John"
  fill_in 'user[family_name]', with: "Smith"
  fill_in 'user[email]', with: "John.Smith@aol.com"
  fill_in 'user[phone_number]', with: "01234567"
  fill_in 'user[description]', with: "asdf asdf"
  choose('user_profession_builder')
end