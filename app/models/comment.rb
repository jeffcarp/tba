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
end
