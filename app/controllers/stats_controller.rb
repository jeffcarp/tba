class StatsController < ApplicationController

  before_filter :authenticate_admin, :only => [:index]

  def index
    @upcoming_issue_posts_count = Issue.upcoming_issue.posts.count
    @users_count = User.count

    @users_this_month = User.where('created_at > ?', 1.month.ago).count
    @users_last_month = User.where('created_at > ? AND created_at < ?', 2.months.ago, 1.month.ago).count
  end

  def issues
    @upcoming_issue = Issue.upcoming_issue
    @upcoming_posts = Post.find(:all, joins: [:issue, :user], conditions: ['issue_id = ?', @upcoming_issue.id], order: 'users.karma DESC')
    @current_issue = Issue.current_issue
=begin
    @posts_per_issue = ActiveRecord::Base.connection.execute "select issues.publish_date as publish_date, count(posts.id) as post_count from issues left outer join posts on posts.issue_id = issues.id group by issues.publish_date order by issues.publish_date desc"
puts @posts_per_issue

    posts_per_issue = []
    x_axis_labels = []
    index = 0
    min = false 
    max = false 
    cumulative_total = 0
    @posts_per_issue.each_with_index do |issue, index|
      x_axis_labels << Date.parse(issue['publish_date']).strftime("%b %-d") if index % 20 == 0
      posts_per_issue << issue['post_count']

      min = issue['post_count'] if !min
      max = issue['post_count'] if !max
      min = issue['post_count'] if issue['post_count'] < min
      max = issue['post_count'] if issue['post_count'] > max
    end
    x_axis_labels.reverse!
    posts_per_issue.reverse!
    puts min
    puts max

    max = max.to_s
    top_quarter = ((max.to_i+min.to_i)*(0.75)).to_s
    half = ((max.to_i+min.to_i).to_i/2).to_s
    bottom_quarter = ((max.to_i+min.to_i).to_i/4).to_s
    min = min.to_s 

    @posts_per_issue_chart = Gchart.line(:size => '600x300',
      :axis_with_labels => 'x,y',
      :axis_labels => [x_axis_labels.join('|'), "#{min}|#{bottom_quarter}|#{half}|#{top_quarter}|#{max}"],
      :bg => '00000000',
      :data => posts_per_issue)
=end
  end

  def email

    @opens = Stat.where('action = ?', 'open_email').order('created_at DESC').limit(20)

    @opens_by_issue = Issue.count('stats.id', joins: [:stats], group: 'stats.issue_id', limit: 20, order: 'stats.issue_id desc')

    opens_data = []
    x_axis_labels = [0]
    index = 0
    min = 1000000
    max = 0
    @opens_by_issue.each_with_index do |open, index|
      # this is quick and dirty and terrible, please forgive me
      x_axis_labels << Issue.find(open[0]).publish_date.strftime("%-m/%-d") #if index % 2 == 0
      opens_data << open[1]
      index += 1
      min = open[1] if open[1] < min
      max = open[1] if open[1] > max
    end
    x_axis_labels.reverse!
    opens_data.reverse!

    @opens_chart = Gchart.bar(:size => '600x200',
      :axis_with_labels => 'x,y',
      :axis_labels => [x_axis_labels.join('|'), "0|#{((max+min)*(0.25)).to_i}|#{((max+min)*(0.50)).to_i}|#{((max+min)*(0.75)).to_i}|#{max}"],
      :bg => '00000000',
      :data => opens_data)

    # Users who have opened today's issue
    opens_today = Stat.where('action = ? AND issue_id = ?', 'open_email', Issue.current_issue).count
    receiving_accounts = Account.where('receive = ?', true).count
    opens_pie_data = [opens_today, receiving_accounts]
    @opens_pie = Gchart.pie(:size => '600x200',
      # :axis_labels => [x_axis_labels.join('|'), "0|#{min}|#{(max+min)/4}|#{(max+min)/2}|#{((max+min)*(0.75)).to_i}|#{max}"],
      :bg => '00000000',
      :labels => 'opened|have not opened',
      :data => [opens_today, receiving_accounts])
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
      x_axis_labels << Date.parse(k).strftime("%b %-d") if index % 10 == 0 && k
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
