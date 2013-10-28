# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Shanghai::Application.initialize!

APP_VERSION = `git describe --always` unless defined? APP_VERSION

ActionMailer::Base.smtp_settings = {
  :user_name => 'colbyio',
  :password => ENV['SENDGRID_COLBYIO_PASS'],
  :domain => 'colby.io',
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}
