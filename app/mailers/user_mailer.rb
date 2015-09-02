class UserMailer < ApplicationMailer

  # def welcome_email(user)
  #   @user = user
  #   @url = 'localhost:3000'
  #   mail(to: @user.email, subject: "Welcome to Get Tradies!")
  # end
  def welcome_email(user, url)
    @user = user
    @url = url
    html_output = render_to_string template: "user_mailer/welcome_email"
    mg_client = Mailgun::Client.new ENV['api_key']
    message_params = {:from    => ENV['gmail_username'],
                      :to      => @user.email,
                      :subject => 'Welcome to GetTradies!',
                      :text    => "Welcome to GetTradies,     \n=====================================                         \nYou have successfully signed up to gettradies.com,\nusing the mail: #{@user.email}.\n\nTo login to the site, just follow this link: #{@url}.\nPlease be sure to complete your user profile.\n\nThanks for joining and have a great day!",
                      :html   => html_output.to_str
                    }
    mg_client.send_message ENV['domain'], message_params
  end

    def tender_created_email(user, url)
    @user = user
    @url = url
    html_output = render_to_string template: "user_mailer/tender_email"
    mg_client = Mailgun::Client.new ENV['api_key']
    message_params = {:from    => ENV['gmail_username'],
                      :to      => @user.email,
                      :subject => 'A Tender From GetTradies!',
                      :text    => "Hello from GetTradies,     \n=====================================                         \nYour job has recieved a new tender.\n\nLogin to the site to view the offer: #{@url}.\n\nThanks for using GetTradies and have a great day!",
                      :html   => html_output.to_str
                    }
    mg_client.send_message ENV['domain'], message_params
  end

    def tender_accepted_email(user, url)
    @user = user
    @url = url
    html_output = render_to_string template: "user_mailer/tender_accepted_email"
    mg_client = Mailgun::Client.new ENV['api_key']
    message_params = {:from    => ENV['gmail_username'],
                      :to      => @user.email,
                      :subject => 'A Tender From GetTradies!',
                      :text    => "Hello from GetTradies,     \n=====================================                         \nYour job tender has been accepted.\n\nLogin to the site to view the client contact details: #{@url}.\n\nThanks for using GetTradies and have a great day!",
                      :html   => html_output.to_str
                    }
    mg_client.send_message ENV['domain'], message_params
  end

  def rating_email(user, url)
    @user = user
    @url = url
    html_output = render_to_string template: "user_mailer/rating_email"
    mg_client = Mailgun::Client.new ENV['api_key']
    message_params = {:from    => ENV['gmail_username'],
                      :to      => @user.email,
                      :subject => 'Your job has been rated on GetTradies!',
                      :text    => "Hello from GetTradies,     \n=====================================                         \nYour job has been rated.\n #{@url}.\n\nThanks for using GetTradies and have a great day!",
                      :html   => html_output.to_str
                    }
    mg_client.send_message ENV['domain'], message_params
  end

end
