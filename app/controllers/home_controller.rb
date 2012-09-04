class HomeController < ApplicationController

  before_filter :authenticate, :only => [:stats, :debug_email]
  caches_page [:index, :guide, :dashboard], :expires_in => 10.minutes

  def index
  end

  def guide
  end

  def dashboard
    @issue = Issue.current_issue
    @posts = Post.find(:all, joins: [:issue, :user], conditions: ['issue_id = ?', @issue.id], order: 'users.karma DESC')
  end

  def stats
    @users_count = User.all.count
    @accounts_count = Account.all.count
    @colby_emails_count = Account.where("email LIKE ?", "%@colby.edu").count
    @colby_accounts_ratio = ((@colby_emails_count.to_f / @accounts_count.to_f) * 100).to_i
    @colby_population_ratio = ((@colby_emails_count.to_f / 1825) * 100).to_i
    @accounts_receive_count = Account.find(:all, conditions: ['receive=?', true]).count
    @accounts_receive_ratio = ((@accounts_receive_count.to_f / @accounts_count.to_f) * 100).to_i

    @votes_today_up = Vote.where('created_at > ? AND created_at < ? AND up = ?', (Time.zone.now).beginning_of_day, (Time.zone.now).end_of_day, true).count
    @votes_today_down = Vote.where('created_at > ? AND created_at < ? AND up = ?', (Time.zone.now).beginning_of_day, (Time.zone.now).end_of_day, false).count
    @votes_yesterday_up = Vote.where('created_at > ? AND created_at < ? AND up = ?', (Time.zone.now - 1.day).beginning_of_day, (Time.zone.now - 1.day).end_of_day, true).count
    @votes_yesterday_down = Vote.where('created_at > ? AND created_at < ? AND up = ?', (Time.zone.now - 1.day).beginning_of_day, (Time.zone.now - 1.day).end_of_day, false).count
    @karma_points_exchanged_today = 10 * (Vote.where('created_at > ? AND created_at < ?', (Time.zone.now).beginning_of_day, (Time.zone.now).end_of_day).count)
    @karma_points_exchanged = 10 * (Vote.where('created_at > ? AND created_at < ?', (Time.zone.now - 1.day).beginning_of_day, (Time.zone.now - 1.day).end_of_day).count)

  end

  def settings
    @checkboxes = true
    @user = current_user
    render 'home/settings'
  end

  def debug_email
    if params[:email] == 'the_announcements'
      template = params[:email]
      @issue = Issue.upcoming_issue
      @posts = Post.find(:all, joins: [:issue, :user], conditions: ['issue_id = ?', @issue.id], order: 'users.karma DESC')
    else
      template = 'welcome_email'
    end

    @url_prefix = 'http://announcements.io/'
    @user = User.find_by_email "gcarpenterv@gmail.com"
    render :layout => false, :template => 'user_mailer/'+template
  end

end

# Wu Tang!