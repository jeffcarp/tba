class UserMailer < ActionMailer::Base
  default :from => "gcarpenterv@gmail.com"


  def welcome_email(user)
    @user = user
    @uri_prefix = 'http://shanghai.herokuapp.com/'
    mail(:to => @user.email, :subject => "Welcome to The Better Announcements!")
  end

  def the_announcements(user, issue)
    @user = user
    @uri_prefix = 'http://shanghai.herokuapp.com/'
    @issue = issue
    if @user.receive
      puts "Sending announcement to "+ @user.email
      mail(:to => @user.email, :subject => "The Better Announcements, " + @issue.publish_date.strftime('%B %-d, %Y'))
    end
  end

end