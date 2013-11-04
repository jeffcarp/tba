class Post < ActiveRecord::Base
  attr_accessible :content, :title, :user_id, :issue_id, :photo_url, :anon
  belongs_to :user
  belongs_to :issue
  has_many :votes

  #validates_length_of :content, maximum: 600
  validates_presence_of :user_id
  validates_presence_of :title, message: "Title cannot be blank. Post not saved."

  def self.popular
    # Post.find(:all, joins: [:user], order: 'users.karma DESC', limit: 10)
    # TODO: Do this without fetching all from DB 
    posts = Post.all.sort {|a,b| b.score <=> a.score }
    posts[0..10]
  end

  def upvote(user)
    already = self.upvoted_by?(user)
    clear_votes(user)
    self.votes << user.votes.new(up: true) if !already
  end

  def downvote(user)
    clear_votes(user)
    self.votes << user.votes.new(up: false)
  end

  def upvotes
    self.votes.where(up: true).count
  end

  def downvotes 
    self.votes.where(up: true).count
  end

  def upvoted_by?(user)
    Vote.where('user_id=? AND post_id=?', user.id, self.id).exists?
  end

  def clear_votes(user)
    vote = user.votes.where('post_id=?', self.id).first
    vote.destroy if vote 
  end

  def content_html
    Maruku.new(self.content).to_html
  end

  # def content_html_with_links
    # self.content
    # Maruku.new(content).to_html
  # end

  def public_user_name
    self.anon ? "Anonymous" : self.user.name
  end

  def score
    # Score = (P-1) / (T+2)^G
    # where
    # P = points of an item (and -1 is to negate submitters vote)
    # T = time since submission (in hours)
    # G = Gravity, defaults to 1.8 in news.arc
    # http://amix.dk/blog/post/19574

    votes = self.upvotes - self.downvotes
    gravity = 1.8 
    hours = (Time.now.to_i - self.created_at.to_i) / 60
    points = (votes+1) / ((hours+2) ** gravity)
    points.round 6 
  end

end
