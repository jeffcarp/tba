class SessionsController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]

    provider = auth["provider"]
    uid = auth["uid"]
    email = auth["info"]["email"]

    @user = User.find(session['user_id'])
    @account = Account.find_by_provider_and_uid(provider, uid)

    if @account
      session['account_id'] = @account.id
      session['user_id'] = @account.user.id
    elsif @user

      @account = User.accounts.create_with_omniauth(auth)

      session['account_id'] = @account.id
      session['user_id'] = @user.id

    else # it's your first time, eh?

      @user = User.new
      @user.name = auth["info"]["name"]
      @user.save

      @account = @user.accounts.create_with_omniauth(auth)

      session['account_id'] = @account.id
      session['user_id'] = @user.id

      # NOT YET, BUT SOON UserMailer.welcome_email(@user).deliver
    end

    redirect_to root_url, :notice => "Signed in!"
  end

  def destroy
    session[:account_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end

end
