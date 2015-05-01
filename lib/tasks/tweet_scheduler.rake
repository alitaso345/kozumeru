desc "This task is called by the Heroku scheduler add-on"
task :import_recent_tweets => :environment do
  puts "Getting tweets..."
  TwitterCrawler.import_recent_tweet
  puts "done."
end

task :premiun_maid_serve_info => :environment do
  crawler = HomePageCrawler.new
  crawler.premium_maid
end
