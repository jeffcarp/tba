class Notifier < ActionMailer::Base
  default from: "hi@colby.io"

  def send_signup_email(email)
    @email = email
    mail( :to => @email,
    :subject => 'Thanks for signing up for our amazing app' )
  end
end
