class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  
  private
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def authenticate
    if !current_user
      redirect_to root_url, notice: "Sorry, you're not logged in. Please follow the login link from one of the emails you've received from us."
    end
  end
end
