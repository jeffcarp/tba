class AccountsController < ApplicationController

  before_filter :authenticate, :only => [:unsubscribe]

  # GET /accounts/:id/unsubscribe
  def unsubscribe

    if !current_user
      # you must be logged in
    else
      @account = Account.find(params[:id])
      if @account
        @account.receive = false
        @account.save
      end
    end
    render :unsubscribe
  end

  # PUT /accounts/1
  # PUT /accounts/1.json
  def update
    @account = current_user.accounts.find(params[:id])

    if params[:receive]
      puts params[:receive]
      @account.receive = params[:receive]
    end

    if @account.update_attributes(params[:account])
      if request.xhr?
        render text: 'Data saved.'
      else
        redirect_to :settings
      end
    else
      if request.xhr?
        render text: 'There was a problem saving.'
      else
        redirect_to :settings, notice: 'There was a problem saving.'
      end
    end
  end

end
