class IssuesController < ApplicationController

  before_filter :authenticate_admin

  def index
    @issues = Issue.order('publish_date DESC')
  end
end
