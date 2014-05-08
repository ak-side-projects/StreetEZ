# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
StreetEZ::Application.initialize!

if Rails.env.production?
  # only send real emails in production; use Sengrid
  ActionMailer::Base.smtp_settings = {
    :address        => 'smtp.sendgrid.net',
    :port           => '587',
    :authentication => :plain,
    :user_name      => ENV['SENDGRID_USERNAME'],
    :password       => ENV['SENDGRID_PASSWORD'],
    :domain         => 'heroku.com'
  }
  ActionMailer::Base.delivery_method ||= :smtp
elsif Rails.env.development?
  ActionMailer::Base.delivery_method = :letter_opener

elsif Rails.env.test?
  ActionMailer::Base.delivery_method = :test
end