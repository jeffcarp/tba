class MobileController < ApplicationController

  def sabot
    @partial = params[:partial]
    render template: 'mobile/sabot'
  end

  def dashboard
    @issue = Issue.current_issue
    @posts = Post.find(:all, joins: [:issue, :user], conditions: ['issue_id = ?', @issue.id], order: 'users.karma DESC')

    render layout: false, template: 'mobile/index'
  end

  def dining_hall
    @issue = Issue.current_issue
    @dining_hall = params[:dining_hall]

    render layout: false, template: 'mobile/dining_hall'
  end
end
