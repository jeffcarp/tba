class UserMailer < ActionMailer::Base
  default :from => "gcarpenterv@gmail.com"
  
  def welcome_email(user)
    @user = user
    @url_prefix = 'http://'+request.host+':'+request.port.to_s+'/'
    mail(:to => @user.email, :subject => "Welcome to The Better Announcements!")
  end
  
  def the_announcements(user, issue)
    @user = user
    @issue = issue
    mail(:to => @user.email, :subject => "The Better Announcements, " + @issue.publish_date.strftime("%F"))
  end

end