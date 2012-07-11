class HomeController < ApplicationController

  def index
    @hide_navigation = true
    @user = User.new
  end
  
  def success
  
  end

end
