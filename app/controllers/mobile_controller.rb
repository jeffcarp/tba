class MobileController < ApplicationController

  caches_page [:dashboard, :foss, :dana, :bobs], :expires_in => 20.minutes

  def dashboard
    @issue = Issue.current_issue #JESUS CHANGE THIS
    @posts = Post.find(:all, joins: [:issue, :user], conditions: ['issue_id = ?', @issue.id], order: 'users.karma DESC')
  end

  def foss
    @issue = Issue.current_issue
    @dining_hall = 'foss'
    render 'mobile/dining_hall'
  end

  def dana
    @issue = Issue.current_issue
    @dining_hall = 'dana'
    render 'mobile/dining_hall'
  end

  def bobs
    @issue = Issue.current_issue
    @dining_hall = 'bobs'
    render 'mobile/dining_hall'
  end


end
