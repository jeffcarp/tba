class Comment < ActiveRecord::Base
  attr_accessible :content, :post_id, :user_id
  belongs_to :user
  belongs_to :post
  validates :post_id, {
    presence: true
  }
  validates :user_id, {
    presence: true
  }
  validates :content, {
    presence: true
  }

  def send_created_email
    people = [self.post.user]
    self.post.comments.each do |c|
      people << c.user
    end
    people.uniq!
    people.delete self.user

    puts people.inspect

    # Send email to post owner
    # Send email to all previous commenters except this guy
    people.each do |u|
      Notifier.comment_created(u, self).deliver
    end
  end
end
