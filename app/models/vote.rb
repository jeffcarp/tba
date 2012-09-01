class Vote < ActiveRecord::Base
  attr_accessible :post_id, :up, :user_id

  belongs_to :post
  belongs_to :user

  validates_presence_of :post_id
  validates_presence_of :user_id
  validates_inclusion_of :up, :in => [true, false]

  validates :user_id, :uniqueness => {:scope => :post_id}
end
