class UserMailer < ActionMailer::Base

  default :from => 'hi@colby.io'
  @uri_prefix = 'http://tba.colby.io/'

  def welcome_email(account)
    puts "SENDING WELCOME EMAIL"
    @account = account
    puts "Sending welcome email to "+ @account.email

    if Rails.env.production?
      to = @account.email
    else
      to = "test-#{@account.email.gsub('@', '-at-')}@colby.io"
    end

    puts mail(to: "gcarpenterv@gmail.com", subject: "Welcome to TBA!")
    puts "SHOULD HAVE SENT WELCOME EMAIL"
  end

  def the_announcements(account, issue)
    @account = account
    @issue = issue

    @hit = 'hit'

    @posts = Post.find(:all, joins: [:issue, :user], conditions: ['issue_id = ?', @issue.id], order: 'users.karma DESC')

    if !Rails.env.production?
      to = "test-#{@account.email}@colby.io"
    else
      to = @account.email
    end

    puts "Sending announcement to "+ @account.email
    mail(to: to, from: "hi@colby.io", subject: "TBA, " + @issue.publish_date.strftime('%B %-d, %Y'))

  end

end
