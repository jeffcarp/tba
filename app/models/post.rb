class Post < ActiveRecord::Base
  attr_accessible :content, :title, :user_id, :issue_id, :photo_url
  belongs_to :user
  belongs_to :issue
  has_many :votes

  validates_length_of :content, maximum: 600
  validates_presence_of :user_id
  validates_presence_of :issue_id
  validates_presence_of :title, message: "Title cannot be blank. Post not saved."

  def content_html
      Maruku.new(self.content).to_html
  end

  # def content_html_with_links
    # self.content
    # Maruku.new(content).to_html
  # end

end
