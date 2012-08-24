class HomeController < ApplicationController

  before_filter :authenticate, :only => [:settings]

  def index
    @hide_navigation = true
    @user = User.new
  end

  def success
    @hide_navigation = true
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
