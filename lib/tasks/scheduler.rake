desc "This task is called by the Heroku scheduler add-on"

task :send_announcements => :environment do
  # HIBERNATING
  # Issue.send_announcements
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