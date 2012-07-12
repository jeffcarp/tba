class Issue < ActiveRecord::Base
  attr_accessible :publish_date
  has_many :posts
  
  def self.upcoming_issue
    Issue.find(:first, :conditions => ["published=?", false], :order => 'publish_date DESC')
  end
  
  def self.create_next
    new_issue = Issue.new
    new_issue.publish_date = self.upcoming_issue.publish_date + 1.days
    new_issue.save
  end
  
  def self.send_announcements
    
    # Get next issue
    @issue = self.upcoming_issue
    
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
  
end
