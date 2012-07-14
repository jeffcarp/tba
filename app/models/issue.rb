class Issue < ActiveRecord::Base
  attr_accessible :publish_date
  has_many :posts
  
  def self.upcoming_issue
    Issue.find(:first, :conditions => ["published=?", false], :order => 'publish_date ASC')
  end
  
  def self.create_next   
    new_issue = Issue.new
    new_issue.publish_date = self.upcoming_issue.publish_date + 1.days
    new_issue.save
    return new_issue
  end
  
  def self.send_announcements
        
    # Get next issue
    @issue = self.upcoming_issue
    
    # Make sure issue's date is today.
    if (@issue.publish_date != Date.today)
      return false
    end
    
    # Errbody in the club get mails
    @users = User.all

    # Cast them off in every direction
    @users.each do |user|
      puts "Sending announcement to "+user.email
      UserMailer.the_announcements(user, @issue).deliver
    end
    
    # Mark this issue as sent
    @issue.published = true
    @issue.save
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
