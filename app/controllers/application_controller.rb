class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user

  private

  def current_user
    if session[:user_id]
      @current_user ||= User.find session[:user_id]
    elsif cookies.signed[:user_id]
      @current_user ||= User.find cookies.signed[:user_id]
    else
      @current_user = nil
    end
  end

  def authenticate
    if !current_user
      redirect_to root_url, notice: "Sorry, you're not logged in."
    end
  end

  def authenticate_admin
    if !current_user || !current_user.admin
      redirect_to root_url, notice: "Sorry, you need to be an admin to see that."
    end
  end
end
