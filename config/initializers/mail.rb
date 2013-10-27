ActionMailer::Base.smtp_settings = {
  :user_name => "announcementsio",
  :password => "timanous",
  :domain => "tba.colby.io",
  :address => "smtp.sendgrid.net",
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => false
}
ActionMailer::Base.delivery_method = :smtp
