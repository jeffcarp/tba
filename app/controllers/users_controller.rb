class UsersController < ApplicationController

  before_filter :authenticate_admin

  def index
    @users = User.order('created_at DESC')
  end

  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  def create
    @user = User.new(params[:user])

    # Send them to success page
    if @user.save
      # Get url_prefix
      # Redirect to success page
      redirect_to '/success'
    else
      # Go back home with errors
      @hide_navigation = true
      render :template => 'home/index'
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    if params[:receive]
      puts params[:receive]
      @user.receive = params[:receive]
    end

    if @user.update_attributes(params[:user])
      if request.xhr?
        render nothing: true
      else
        redirect_to :settings
      end
    else
      if request.xhr?
        render nothing: true
      else
        redirect_to :settings, notice: 'There was a problem saving.'
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
