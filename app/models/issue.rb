class Issue < ActiveRecord::Base
  attr_accessible :publish_date
  has_many :posts, :dependent => :destroy
  has_many :stats

  def self.upcoming_issue
    Issue.find(:first, :conditions => ["published=?", false], :order => 'publish_date ASC')
  end

  def self.current_issue
    Issue.find(:last, :conditions => ["published=?", true], :order => 'publish_date ASC')
  end

  # Deprecated.
  def self.todays_issue
    Issue.find(:first, :conditions => ["publish_date=?", Time.zone.now.strftime('%F')])
  end

  def self.create_next
    issue = Issue.new
    furthest_issue = Issue.find(:first, :order => 'publish_date DESC')
    issue.publish_date = furthest_issue.publish_date + 1.days
    issue.save
    return issue
  end

  def mark_as_published
    self.published = true
    if self.save
      return self
    else
      return false
    end
  end

  def self.send_announcements

    puts "Sending announcements..."

    @accounts = Account.all
    @issue = Issue.upcoming_issue

    # Exed out for testing purposes.
    # if @issue.publish_date != Date.today
      # puts "Cannot publish another day's issue."
      # return false
    # end

    @issue.mark_as_published

    @accounts.each do |account|
      if account.receive
        puts "Sending to #{account.email}"
        Notifier.announcements(account, @issue).deliver
        # UserMailer.the_announcements(account, @issue).deliver
      end
    end

    puts "Done sending all announcements."
  end

  def self.create_week_from_scratch
    date = Date.today
    first = true
    (0..6).each do |i|
      issue = Issue.new
      issue.publish_date = date
      issue.published = true if first
      first = false
      issue.save
      puts "Created next issue publishing " + issue.publish_date.strftime('%F')
      date = date + 1.days
    end
  end

  def self.fetch_upcoming_menus

    @issue = Issue.upcoming_issue

    # EVENTUALLY MOVE TO LIB OR GEM
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

    @issue.dana = @dana

    # OH THE HUMANITY

    @dana_dinner = @stuff.css("item")[1].to_s

    @dana_dinner.gsub!(/&amp;/, "&")
    @dana_dinner.gsub!(/&lt;/, "<")
    @dana_dinner.gsub!(/&gt;/, ">")
    @dana_dinner.gsub!(/(<[pubdate|category|author].*[pubdate|category|author]>)/, "")
    @dana_dinner.gsub!(/(http:\/\/.*.$)/, "")

    @issue.dana_dinner = @dana_dinner

    # EVENTUALLY MOVE TO LIB OR GEM
    url = URI.parse('http://www.colby.edu/news/feeds/dining-Foss.xml')
    req = Net::HTTP::Get.new(url.path)
    res = Net::HTTP.start(url.host, url.port) { |http|
      http.request(req)
    }
    @stuff = Nokogiri::XML(res.body)

    @foss = @stuff.css("item").first.to_s

    @foss.gsub!(/&amp;/, "&")
    @foss.gsub!(/&lt;/, "<")
    @foss.gsub!(/&gt;/, ">")
    @foss.gsub!(/(<[pubdate|category|author].*[pubdate|category|author]>)/, "")
    @foss.gsub!(/(http:\/\/.*.$)/, "")

    @issue.foss = @foss

    # OH THE HUMANITY

    @foss_dinner = @stuff.css("item")[1].to_s

    @foss_dinner.gsub!(/&amp;/, "&")
    @foss_dinner.gsub!(/&lt;/, "<")
    @foss_dinner.gsub!(/&gt;/, ">")
    @foss_dinner.gsub!(/(<[pubdate|category|author].*[pubdate|category|author]>)/, "")
    @foss_dinner.gsub!(/(http:\/\/.*.$)/, "")

    @issue.foss_dinner = @foss_dinner

    # EVENTUALLY MOVE TO LIB OR GEM
    url = URI.parse('http://www.colby.edu/news/feeds/dining-Roberts.xml')
    req = Net::HTTP::Get.new(url.path)
    res = Net::HTTP.start(url.host, url.port) { |http|
      http.request(req)
    }
    @stuff = Nokogiri::XML(res.body)

    @bobs = @stuff.css("item").first.to_s

    @bobs.gsub!(/&amp;/, "&")
    @bobs.gsub!(/&lt;/, "<")
    @bobs.gsub!(/&gt;/, ">")
    @bobs.gsub!(/(<[pubdate|category|author].*[pubdate|category|author]>)/, "")
    @bobs.gsub!(/(http:\/\/.*.$)/, "")

    @issue.bobs = @bobs

    @bobs_dinner = @stuff.css("item")[1].to_s

    @bobs_dinner.gsub!(/&amp;/, "&")
    @bobs_dinner.gsub!(/&lt;/, "<")
    @bobs_dinner.gsub!(/&gt;/, ">")
    @bobs_dinner.gsub!(/(<[pubdate|category|author].*[pubdate|category|author]>)/, "")
    @bobs_dinner.gsub!(/(http:\/\/.*.$)/, "")

    @issue.bobs_dinner = @bobs_dinner

    if @issue.save
      return true
    else
      return false
    end
  end

end
