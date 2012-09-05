class UserMailer < ActionMailer::Base
  default from: "gcarpenterv@gmail.com"

  def welcome_email(account)
    @account = account
    @uri_prefix = 'http://announcements.io/'
    puts "Sending welcome email to "+ @account.email
    mail(to: @account.email, subject: "Welcome to The Better Announcements!")
  end

  def the_announcements(account, issue)
    @account = account
    @uri_prefix = 'http://announcements.io/'
    @issue = issue
    @posts = Post.find(:all, joins: [:issue, :user], conditions: ['issue_id = ?', @issue.id], order: 'users.karma DESC')
    if @account.receive
      puts "Sending announcement to "+ @account.email
      mail(to: @account.email, subject: "The Better Announcements, " + @issue.publish_date.strftime('%B %-d, %Y'))
    end
  end

end