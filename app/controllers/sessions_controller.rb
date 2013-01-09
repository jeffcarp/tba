class SessionsController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]

    provider = auth["provider"]
    uid = auth["uid"]
    email = auth["info"]["email"]
    name = auth["info"]["name"]

    @account = Account.find_by_provider_and_uid(provider, uid)

    if !@account # This is the first time logging in with that email

      @user = User.create!
      @user.name = auth["info"]["name"]
      @user.save

      @account = @user.accounts.create_with_omniauth(auth)

      UserMailer.delay.welcome_email(@account)
    end

    session[:account_id] = @account.id
    session[:user_id] = @account.user.id
    cookies.permanent.signed[:user_id] = @account.user.id

    redirect_to root_url, :notice => "Signed in!"
  end

  def destroy
    session.delete(:account_id)
    session.delete(:user_id)
    cookies.delete(:user_id)
    redirect_to root_url, :notice => "Signed out!"
  end

end
