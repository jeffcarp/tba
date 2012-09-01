class SessionsController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]

    unless @user = Account.find_by_provider_and_uid(auth["provider"], auth["uid"])

      # To catch and convert legacy users!
      if (@user = User.find_by_email auth["info"]["email"])
        @user.canpost = true
        @user.provider = auth["provider"]
        @user.uid = auth["uid"]
        @user.name = auth["info"]["name"]
        @user.save
      else
        @user = User.create_with_omniauth(auth)
        UserMailer.welcome_email(@user).deliver
      end
    end

    session[:user_id] = @user.id
    redirect_to root_url, :notice => "Signed in!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end

end
