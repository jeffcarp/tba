class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user

  private

  def current_user
    @current_user ||= Account.find(session[:account_id]).user if session[:account_id]
  end

  def authenticate
    if !current_user
      redirect_to root_url, notice: "Sorry, you're not logged in. Please follow the login link from one of the emails you've received from us."
    end
  end

  def authenticate_admin
    if !current_user || !current_user.admin
      redirect_to root_url, notice: "Sorry, you need to be an admin to see that."
    end
  end
end