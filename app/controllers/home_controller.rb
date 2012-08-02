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

  def auth
    # /auth?s=8835da40e39c591e9cf0d9976ccae338&e=gccarpen%40colby.edu&l=%2Fsettings
    salt = params[:s]
    email = params[:e]
    location = params[:l]

    @user = User.find_by_email(email)

    # If user's email is in DB and salt in URL matches user's salt
    if (@user && @user.salt == salt)

      # Give them a session
      session[:user_id] = @user.id

      # And go to specified location
      redirect_to location
    else
      # Otherwise, give them a helpful message
      ## "Sorry, either you were given a wrong URL or.."
      ## flash.now.alert = "Invalid email or password"

      # And send them to the main page
    redirect_to :root
    end
  end

end
