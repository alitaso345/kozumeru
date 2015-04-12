desc "This task is called by the Heroku scheduler add-on"
task :import_recent_tweets => :environment do
  puts "Getting tweets..."
  Tweet.import_recent_tweet
  puts "done."
end
