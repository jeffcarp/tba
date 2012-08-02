class UsersController < ApplicationController

  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  def create
    @user = User.new(params[:user])

    # Make them a hash
    @user.salt = Digest::MD5.hexdigest(params[:user][:email])

    # Send them to success page
    if @user.save
      # Get url_prefix
#       @url_prefix = 'http://'+request.host+':'+request.port.to_s+'/'
      @url_prefix = 'http://shanghai.herokuapp.com/'

      # Send them an email
      UserMailer.welcome_email(@user).deliver

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
      redirect_to :settings
    else
      redirect_to :settings, notice: 'There was a problem saving.'
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
