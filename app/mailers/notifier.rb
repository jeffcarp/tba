class Notifier < ActionMailer::Base
  default from: "hi@colby.io"
  @base_url = "http://tba.colby.io"

  def send_signup_email(email)
    @email = email
    mail( :to => @email,
    :subject => 'Thanks for signing up for our amazing app' )
  end

  def someone_signed_up(user)
    @user = user
    mail(to: "hi@colby.io", subject: "#{@user.name} just signed up on colby.io")
  end

  def announcements(account, issue)
    @account = account
    @issue = issue

    @posts = Post.find(:all, joins: [:issue, :user], conditions: ['issue_id = ?', @issue.id], order: 'users.karma DESC')

    if !Rails.env.production?
      to = "test-#{@account.email.gsub('@', '-at-')}@colby.io"
    else
      to = @account.email
    end

    subject = "TBA, " + @issue.publish_date.strftime('%B %-d, %Y')

    mail( :to => to, :subject => subject) 

  end
end
