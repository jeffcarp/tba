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

task :get_idle_accounts => :environment do
  User.all.each do |user|
    if user.stats.count == 0 && user.accounts.first.receive
      puts "#{user.name} has never opened an email"
    end
  end
end
