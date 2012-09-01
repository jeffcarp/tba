class User < ActiveRecord::Base
  attr_accessible

  has_many :posts
  has_many :accounts
  has_many :votes

  # validates_uniqueness_of :email, :message => "%{value} has already been registered. To log into your account, follow the login link in an email from us."
  validates_presence_of :email
  validates_length_of :name, maximum: 128

  # validates :email,
  #   :format => {
  #     :with => /^[_A-Za-z0-9-]+(\\.[_A-Za-z0-9-]+)*@colby.edu/,
  #     :message => "must be @colby.edu."
  #   }

  def has_voted_on (post)
    Vote.find(:first, conditions: ['post_id = ? AND user_id = ?', post.id, self.id])
  end

  def give_karma(points)
    self.karma += points
    self.save
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
