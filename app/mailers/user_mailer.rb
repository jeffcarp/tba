class UserMailer < ActionMailer::Base
  default :from => "gcarpenterv@gmail.com"
  
  def welcome_email(email)
    mail(:to => email, :subject => "Welcome to The Better Announcements!")
  end
  
  def the_announcements(user, issue)
    mail(:to => user.email, :subject => "The Better Announcements, "+issue.publish_date.strftime("%F"))
  end
  
end
