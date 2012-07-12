desc "This task is called by the Heroku scheduler add-on"
task :send_announcements => :environment do
    puts "Sending announcements..."
    Issue.send_announcements
    puts "Done sending all announcements."
end