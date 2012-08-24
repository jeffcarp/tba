class User < ActiveRecord::Base
  attr_accessible :email, :name, :salt
  has_many :posts

  # validates_uniqueness_of :email, :message => "%{value} has already been registered. To log into your account, follow the login link in an email from us."
  validates_presence_of :email

  # validates :email,
  #   :format => {
  #     :with => /^[_A-Za-z0-9-]+(\\.[_A-Za-z0-9-]+)*@colby.edu/,
  #     :message => "must be @colby.edu."
  #   }

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.email = auth["info"]["email"]
      user.name = auth["info"]["name"]
    end
  end
end
