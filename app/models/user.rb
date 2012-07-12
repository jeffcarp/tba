class User < ActiveRecord::Base
  attr_accessible :email, :name, :salt
  has_many :posts
  
  validates_uniqueness_of :email, :message => "%{value} has already been registered. If this is yours, please contact either of us and we'll fix it immediately."
  validates_presence_of :email
  
  validates :email, 
    :format => { 
      :with => /^[_A-Za-z0-9-]+(\\.[_A-Za-z0-9-]+)*@colby.edu/,
      :message => "must be @colby.edu." 
    }
end
