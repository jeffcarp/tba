class Issue < ActiveRecord::Base
  attr_accessible :publish_date
  has_many :posts
  
  def self.upcoming_issue
    Issue.find(:first, :conditions => ["published=?", false], :order => 'publish_date DESC')
  end
  
  def self.create_next
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
  end
  
end
