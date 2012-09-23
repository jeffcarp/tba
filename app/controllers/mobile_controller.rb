class MobileController < ApplicationController

  def index
    @issue = Issue.current_issue
    @posts = Post.find(:all, joins: [:issue, :user], conditions: ['issue_id = ?', @issue.id], order: 'users.karma DESC')
  end

  def dining_hall
    url = URI.parse('http://www.colby.edu/news/feeds/dining-Dana.xml')
    req = Net::HTTP::Get.new(url.path)
    res = Net::HTTP.start(url.host, url.port) { |http|
      http.request(req)
    }
    @stuff = Nokogiri::XML(res.body)

    @dana = @stuff.css("item").first.to_s

    @dana.gsub!(/&amp;/, "&")
    @dana.gsub!(/&lt;/, "<")
    @dana.gsub!(/&gt;/, ">")
    @dana.gsub!(/(<[pubdate|category|author].*[pubdate|category|author]>)/, "")
    @dana.gsub!(/(http:\/\/.*.$)/, "")
  end
end
