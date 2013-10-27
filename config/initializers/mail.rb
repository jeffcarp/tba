ActionMailer::Base.smtp_settings = {
  :user_name => "colbyio",
  :password => "timanous",
  :domain => "colby.io",
  :address => "smtp.sendgrid.net",
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true 
}
ActionMailer::Base.delivery_method = :smtp
