  ActionMailer::Base.smtp_settings = {
    :address        => 'smtp.sendgrid.net',
    :port           => '587',
    :authentication => :plain,
    # :user_name      => 'announcementsio',
    # :password       => 'timanous',
    :user_name      => 'app5816144@heroku.com',
    :password       => 'hdvkhgew',
    :domain         => 'heroku.com'
  }
  ActionMailer::Base.delivery_method = :smtp