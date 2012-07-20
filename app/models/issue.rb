class Issue < ActiveRecord::Base
  attr_accessible :publish_date
  has_many :posts

  def self.upcoming_issue
    Issue.find(:first, :conditions => ["published=?", false], :order => 'publish_date ASC')
  end

  def self.create_next
    issue = Issue.new
    issue.publish_date = self.upcoming_issue.publish_date + 1.days
    issue.save
    return issue
  end

  def self.mark_as_published
    self.published = true
    if self.save
      return self
    else
      return false
    end
  end

  def self.send_announcements
    puts "Sending announcements..."

    @users = User.all
    @issue = self.upcoming_issue

    return false if !@issue.posts.any?
    return false if @issue.publish_date != Date.today

    @users.each do |user|
      UserMailer.the_announcements(user, @issue).deliver
    end

    @issue.mark_as_published

    puts "Done sending all announcements."
  end

  def self.create_week_from_scratch
    date = Date.today
    (0..6).each do |i|
      issue = Issue.new
      issue.publish_date = date
      issue.save
      puts "Created next issue publishing " + issue.publish_date.strftime('%F')
      date = date + 1.days
    end
  end

end
