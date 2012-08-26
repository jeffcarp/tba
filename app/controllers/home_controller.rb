class HomeController < ApplicationController

  before_filter :authenticate, :only => [:settings]

  def index
  end

  def guide
    # Wu Tang!
  end

  def stats
    @users_count = User.all.count
    @users_receive_count = User.find(:all, conditions: ['receive=?', true]).count
    @users_receive_ratio = ((@users_receive_count.to_f / @users_count.to_f) * 100).to_i
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
    else
      template = 'welcome_email'
    end

    @url_prefix = 'http://shanghai.herokuapp.com/'
    @user = User.find_by_email "gccarpen@colby.edu"
    render :layout => false, :template => 'user_mailer/'+template
  end

end
