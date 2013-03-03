class StatsController < ApplicationController

  before_filter :authenticate_admin, :only => [:index]

  def index
    @upcoming_issue_posts_count = Issue.upcoming_issue.posts.count
    @users_count = User.count
    @users_week_delta = User.count - User.where('created_at < ?', 1.week.ago).count
    @users_month_delta = User.count - User.where('created_at < ?', 1.month.ago).count
  end

  def issues
    @upcoming_issue = Issue.upcoming_issue
    @upcoming_posts = Post.find(:all, joins: [:issue, :user], conditions: ['issue_id = ?', @upcoming_issue.id], order: 'users.karma DESC')
    @current_issue = Issue.current_issue
  end

  def email

    # User.all.each do |user|
    #   user.created_at = user.created_at.to_formatted_s(:db)
    #   user.updated_at = user.updated_at.to_formatted_s(:db)
    #   user.save
    # end

    @opens = Stat.where('action = ?', 'open_email').order('created_at DESC').limit(20)
    # @opens_grouped = Stat.where('action = ?', 'open_email').group('date(created_at)').order('created_at DESC').count
    @opens_grouped = Stat.count(:conditions => ["action = ?", 'open_email'], :order => 'DATE(created_at) DESC', :group => ["DATE(created_at)"])
    # @votes_grouped = Vote.where('action = ?', 'open_email').group('date(created_at)').order('created_at DESC').count
# User.find_by_sql

    opens_data = []
    x_axis_labels = [0]
    index = 0
    min = 1000000
    max = 0
    @opens_grouped.each do |k,v|
      x_axis_labels << Date.parse(k).strftime("%-m/%-d") #if index % 2 == 0
      opens_data << v
      index += 1
      min = v if v < min
      max = v if v > max
    end
    x_axis_labels.reverse!
    # opens_data.reverse!

    @opens_chart = Gchart.bar(:size => '600x200',
      :axis_with_labels => 'x,y',
      :axis_labels => [x_axis_labels.join('|'), "0|#{min}|#{(max+min)/4}|#{(max+min)/2}|#{((max+min)*(0.75)).to_i}|#{max}"],
      :bg => '00000000',
      :data => opens_data)

    # Users who have opened today's issue
    opens_today = Stat.where('action = ? AND created_at > ?', 'open_email', Date.today.beginning_of_day).count
    receiving_accounts = Account.where('receive = ?', true).count
    opens_pie_data = [opens_today, receiving_accounts]
    @opens_pie = Gchart.pie(:size => '600x200',
      # :axis_labels => [x_axis_labels.join('|'), "0|#{min}|#{(max+min)/4}|#{(max+min)/2}|#{((max+min)*(0.75)).to_i}|#{max}"],
      :bg => '00000000',
      :labels => 'opened|have not opened',
      :data => [opens_today, receiving_accounts])

    # @todays_opens_chart = 
  end

  def users
    @users = User.count(:order => 'date(created_at) DESC', :group => ["date(created_at)"])

    opens_data = []
    x_axis_labels = []
    index = 0
    min = 1000000
    max = 0
    cumulative_total = 0
    @users.each do |k,v|
      x_axis_labels << Date.parse(k).strftime("%b %-d") if index % 10 == 0
      cumulative_total += v
      opens_data << cumulative_total
      index += 1
      min = cumulative_total if cumulative_total < min
      max = cumulative_total if cumulative_total > max
    end
    x_axis_labels.reverse!
    # opens_data.reverse!

    @users_chart = Gchart.line(:size => '600x300',
      :axis_with_labels => 'x,y',
      :axis_labels => [x_axis_labels.join('|'), "#{min}|#{(max+min)/4}|#{(max+min)/2}|#{((max+min)*(0.75)).to_i}|#{max}"],
      :bg => '00000000',
      :data => opens_data)
  end

  def image
    stat = Stat.new(:user_id => params[:user_id], :action => 'open_email', :issue_id => params[:issue_id])
    stat.save
    redirect_to "/assets/1x1.gif"
  end

end
