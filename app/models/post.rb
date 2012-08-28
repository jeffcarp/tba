class Post < ActiveRecord::Base
  attr_accessible :content, :title, :user_id, :issue_id
  belongs_to :user
  belongs_to :issue

  def content_html
      Maruku.new(self.content).to_html
  end

end
