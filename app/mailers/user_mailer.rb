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


    @forecast = Rails.cache.read('weather', @forecast)
    @hit = 'hit'
    if !@forecast
      @hit = 'miss'
      wuapi = Wunderground.new("ae554e13f3e3461e")
      @forecast = wuapi.forecast_and_conditions_for("ME", "Waterville")
      Rails.cache.write('weather', @forecast, expires_in: 12.hours)
    end

    @posts = Post.find(:all, joins: [:issue, :user], conditions: ['issue_id = ?', @issue.id], order: 'users.karma DESC')
    if @account.receive
      puts "Sending announcement to "+ @account.email
      mail(to: @account.email, subject: "The Better Announcements, " + @issue.publish_date.strftime('%B %-d, %Y'))
    end
  end

end