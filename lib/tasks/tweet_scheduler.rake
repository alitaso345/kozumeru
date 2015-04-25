desc "This task is called by the Heroku scheduler add-on"
task :import_recent_tweets => :environment do
  puts "Getting tweets..."
  TwitterCrawler.import_recent_tweet
  puts "done."
end

task :import_blogs => :environment do
  puts "Getting pictures..."
  HomePageCrawler.import_blogs
  puts "done..."
end
