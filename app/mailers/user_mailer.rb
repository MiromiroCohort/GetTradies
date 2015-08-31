require 'mailgun'
class UserMailer < ApplicationMailer

  # def welcome_email(user)
  #   @user = user
  #   @url = 'localhost:3000'
  #   mail(to: @user.email, subject: "Welcome to Get Tradies!")
  # end
  def welcome_email(user)
    @user = user
    mg_client = Mailgun::Client.new ENV['api_key']
    message_params = {:from    => ENV['gmail_username'],
                      :to      => @user.email,
                      :subject => 'Welcome to GetTradies!',
                      :text    => "Welcome to GetTradies,     \n=====================================                         \nYou have successfully signed up to gettradies.com,\nusing the mail: #{@user.email}.\n\nTo login to the site, just follow this link: #{@url}.\nPlease be sure to complete your user profile.\n\nThanks for joining and have a great day!"}
    mg_client.send_message ENV['domain'], message_params
  end

end

# ,     \n=====================================                         \nYou have successfully signed up to gettradies.com,\nusing the mail: #{@user.email}.\n\nTo login to the site, just follow this link: #{@url}.\nPlease be sure to complete your user profile.\n\nThanks for joining and have a great day!"
