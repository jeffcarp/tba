class HomeController < ApplicationController

  before_filter :authenticate, :only => [:stats, :settings]
  caches_page [:index, :guide, :dashboard], :expires_in => 10.minutes

  def index
  end

  def guide
  end

  def dashboard
    @all_posts = Post.where("photo_url != ''")
    @issue = Issue.current_issue
    if params[:upcoming]
      @issue = Issue.upcoming_issue
    end
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

    @likes_today = Vote.where('created_at > ? AND created_at < ?', (Time.zone.now).beginning_of_day, (Time.zone.now).end_of_day).count
    @likes_yesterday = Vote.where('created_at > ? AND created_at < ?', (Time.zone.now - 1.day).beginning_of_day, (Time.zone.now - 1.day).end_of_day).count
    @likes_ototoi = Vote.where('created_at > ? AND created_at < ?', (Time.zone.now - 2.day).beginning_of_day, (Time.zone.now - 2.day).end_of_day).count
  end

  def settings
    @checkboxes = true
    @user = current_user
    @votes = Vote.find(:all, joins: ['JOIN posts ON posts.id = votes.post_id'], conditions: ['posts.user_id = ?', current_user.id], order: "created_at DESC")
    render 'home/settings'
  end

  def debug_email

    @account = current_user.accounts.first
    wuapi = Wunderground.new("ae554e13f3e3461e")
    @forecast = wuapi.forecast_and_conditions_for("ME", "Waterville")

    @issue = Issue.upcoming_issue
    if params[:current]
      @issue = Issue.current_issue
    end

    @posts = Post.find(:all, joins: [:issue, :user], conditions: ['issue_id = ?', @issue.id], order: 'users.karma DESC')

    @url_prefix = 'http://announcements.io/'
    @user = User.find_by_email "gcarpenterv@gmail.com"
    render :layout => false, :template => 'user_mailer/the_announcements'
  end

end

# Wu Tang!