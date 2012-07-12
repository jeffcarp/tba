desc "This task is called by the Heroku scheduler add-on"

task :send_announcements => :environment do
  puts "Sending announcements..."
  Issue.send_announcements
  puts "Done sending all announcements."
end

task :create_next_issue => :environment do
  @issue = Issue.create_next
  puts "Created next issue publishing " + @issue.publish_date.strftime('%F')
end