desc "This task is called by the Heroku scheduler add-on"

task :send_announcements => :environment do
  puts "rake send_announcements"
  puts Time.now
  Issue.send_announcements
end

task :mark_as_published_without_sending => :environment do
  puts "rake mark_as_published_without_sending"
  puts Time.now
  Issue.upcoming_issue.mark_as_published
end

task :create_next_issue => :environment do
  puts "rake create_next_issue"
  puts Time.now
  issue = Issue.create_next
  puts "Created next issue publishing " + issue.publish_date.strftime('%F')
end

task :create_week_from_scratch => :environment do
  puts "rake create_week_from_scratch"
  puts Time.now
  Issue.create_week_from_scratch
end

task :fetch_upcoming_menus => :environment do
  puts "rake fetch_upcoming_menus"
  puts Time.now
  Issue.fetch_upcoming_menus
end

task :get_idle_accounts => :environment do
  User.all.each do |user|
    if user.stats.count == 0 && user.accounts.first.receive
      puts "#{user.name} has never opened an email"
    end
  end
end
