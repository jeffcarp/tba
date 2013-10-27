class UserMailer < ActionMailer::Base

  @uri_prefix = 'http://tba.colby.io/'

  def welcome_email(account)
    @account = account
    puts "Sending welcome email to "+ @account.email

    if !Rails.env.production?
      to = "test-#{@account.email}@tba.colby.io"
    else
      to = @account.email
    end

    mail(to: to, from: "tba@colby.io", subject: "Welcome to TBA!")
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
    mail(to: to, from: "tba@colby.io", subject: "TBA, " + @issue.publish_date.strftime('%B %-d, %Y'))

  end

end
