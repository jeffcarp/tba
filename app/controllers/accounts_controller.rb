class AccountsController < ApplicationController

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
