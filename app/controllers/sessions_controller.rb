class SessionsController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]

    provider = auth["provider"]
    uid = auth["uid"]
    email = auth["info"]["email"]
    name = auth["info"]["name"]

    @user = User.find(session[:user_id]) if session[:user_id]
    @account = Account.find_by_provider_and_uid(provider, uid)

    if @account # Their cookie expired or they logged out
      puts 'Log em in'
      session[:account_id] = @account.id
      session[:user_id] = @account.user.id
    elsif @user # They're logging in with a new account
      puts 'Create new Account'
      @account = @user.accounts.create_with_omniauth(auth)

      session['account_id'] = @account.id
      session['user_id'] = @user.id

    else # it's your first time, eh?
      puts 'Create new User and Account'
      @user = User.create!
      @user.name = auth["info"]["name"]
      @user.save

      puts @user.inspect

      @account = @user.accounts.create_with_omniauth(auth)

      session['account_id'] = @account.id
      session['user_id'] = @user.id

      UserMailer.delay.welcome_email(@user)
      # NOT YET, BUT SOON UserMailer.welcome_email(@user).deliver
    end

    redirect_to root_url, :notice => "Signed in!"
  end

  def destroy
    if params[:super] == 'yes'
      # hmm
    end
    session[:account_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end

end
