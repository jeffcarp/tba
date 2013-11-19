class User < ActiveRecord::Base

  attr_accessible :name

  has_many :posts, :dependent => :destroy
  has_many :accounts, :dependent => :destroy
  has_many :votes, :dependent => :destroy
  has_many :stats
  has_many :comments, :dependent => :destroy

  validates_length_of :name, maximum: 128

  def primary_email
    self.accounts.first.email
  end

  def has_voted_on(post)
    Vote.find(:first, conditions: ['post_id = ? AND user_id = ?', post.id, self.id])
  end

  def give_karma(points)
    self.karma += points
    self.save
  end

  def posts_count
    return self.posts.count
  end

  def likes_per_post
  end

  def likes_on_posts
    # Votes where post.user = User
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.email = auth["info"]["email"]
      user.name = auth["info"]["name"]

      if user.email.include? '@colby.edu'
        user.canpost = true
      end

    end
  end

end
