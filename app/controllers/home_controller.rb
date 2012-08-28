class HomeController < ApplicationController

  before_filter :authenticate, :only => [:settings]

  def index
  end

  def guide
  end

  def dashboard
    @issue = Issue.todays_issue
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

    @url_prefix = 'http://announcements.io/'
    @user = User.find_by_email "gcarpenterv@gmail.com"
    render :layout => false, :template => 'user_mailer/'+template
  end

end

# Wu Tang!