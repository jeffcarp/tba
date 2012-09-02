class Account < ActiveRecord::Base
  attr_accessible :provider, :uid, :user_id, :email

  belongs_to :user

  validates_presence_of :user_id, :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider


  def self.create_with_omniauth(auth)
    create! do |account|
      account.provider = auth["provider"]
      account.uid = auth["uid"]
      account.email = auth["info"]["email"]

      if account.email.include? '@colby.edu'
        account.user.canpost = true
        account.user.save
      end

    end
  end
end