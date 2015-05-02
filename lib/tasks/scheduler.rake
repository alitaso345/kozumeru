desc "This task is called by the Heroku scheduler add-on"
task :import_recent_tweets => :environment do
  puts "Getting tweets..."
  crawler = TwitterCrawler.new
  crawler.import_recent_tweet
  puts "done."
end

task :import_posts => :environment do
  puts "Getting blog posts..."
  HomePageCrawler.import_posts
  puts "done..."
end
