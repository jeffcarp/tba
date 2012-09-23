class MobileController < ApplicationController

  def index
    @issue = Issue.current_issue
    @posts = Post.find(:all, joins: [:issue, :user], conditions: ['issue_id = ?', @issue.id], order: 'users.karma DESC')
  end

  def dining_hall
    @issue = Issue.current_issue
    @dining_hall = params[:dining_hall]
  end
end
