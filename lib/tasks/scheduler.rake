desc "This task is called by the Heroku scheduler add-on"

task :send_announcements => :environment do
  Issue.send_announcements
end

task :create_next_issue => :environment do
  issue = Issue.create_next
  puts "Created next issue publishing " + issue.publish_date.strftime('%F')
end

task :create_week_from_scratch => :environment do
  Issue.create_week_from_scratch
end

task :fetch_upcoming_menus => :environment do
  Issue.fetch_upcoming_menus
end

task :calculate_ranks => :environment do
  @posts = Issue.upcoming_issue.posts

  @guess_hash = {}
  @posts.each do |post|

    guessed_height = 0

    if post.photo_url
        image_height = FastImage.size(post.photo_url+"/convert?w=288")
        guessed_height += image_height.last if image_height
    end

    guessed_height += (post.title.length / 34.0).ceil*21.0

    guessed_height += (post.content.length / 42.0).ceil*15.7

    @guess_hash[post.id] = guessed_height

  end

  # now divide them up into two categories where the difference betwen the sums of the two is the least
  @left_side
  @right_side



end

task :get_idle_accounts => :environment do
  User.all.each do |user|
    if user.stats.count == 0 && user.accounts.first.receive
      puts "#{user.name} has never opened an email"
    end
  end
end
