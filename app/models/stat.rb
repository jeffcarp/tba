class Stat < ActiveRecord::Base
  attr_accessible :action, :user_id, :issue_id
  belongs_to :user
  belongs_to :issue
end
