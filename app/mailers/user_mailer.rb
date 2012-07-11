class UserMailer < ActionMailer::Base
  default :from => "gcarpenterv@gmail.com"
  
  def welcome_email(email)
    mail(:to => email, :subject => "Welcome to My Awesome Site")
  end
  
end
