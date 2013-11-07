class HomeController < ApplicationController

  before_filter :authenticate, :only => [:stats, :settings]
  caches_page [:index, :guide, :dashboard], :expires_in => 10.minutes

  def index
    @aside_title = "Home"
    @posts = Post.popular
    @post = @posts.first
    render 'posts/show'
  end

  def guide
    @colby_emails_count = Account.where("email LIKE ?", "%@colby.edu").count
    @colby_percentage = ((@colby_emails_count.to_f / 1825) * 100).to_i
  end

  def tomorrow 
    @issue = Issue.upcoming_issue
    @posts = Post.find(:all, joins: [:issue, :user], conditions: ['issue_id = ?', @issue.id], order: 'users.karma DESC')
  end

  def settings
    @checkboxes = true
    @user = current_user
    @posts = current_user.posts
    render 'home/settings'
  end

  def debug_email

    @account = current_user.accounts.first

    @issue = Issue.upcoming_issue
    if params[:current]
      @issue = Issue.current_issue
    end

    @posts = Post.find(:all, joins: [:issue, :user], conditions: ['issue_id = ?', @issue.id], order: 'users.karma DESC')

    @uri_prefix = 'http://localhost:3000/'
    @user = User.find_by_email "gcarpenterv@gmail.com"
    render :layout => false, :template => 'notifier/announcements'
  end

  def search
    q = params[:q]
    q_sql = '%'+q+'%'
    results = {}
    if Rails.env == "production"
      like = "ILIKE"
    else
      like = "LIKE"
    end
    results[:users] = User.find(:all, :conditions => ["name #{like} ?", q_sql], :limit => 5, :order => 'created_at DESC')
    # Zip up matched user names with their primary account, and matched email addresses with their user
    # results[:accounts] = Account.find(:all, :conditions => ['email LIKE ?', q_sql])
    results[:posts] = Post.find(:all, :conditions => ["title #{like} ? OR content #{like} ?", q_sql, q_sql], :limit => 5, :order => 'created_at DESC')
    results[:posts].map do |post|
      post[:formatted_date] = post.issue.publish_date.strftime('%B %-d, %Y')
      if post.anon
        post[:user_name] = "Anonymous"
      else
        post[:user_name] = post.user.name
      end
    end

    render :json => results
  end

end
