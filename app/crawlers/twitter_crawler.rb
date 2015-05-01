class TwitterCrawler
  def initialize
    @client = TwitterClient.new
  end

  def import_recent_tweet
    accounts = TwitterAccount.all.select('id, screen_name')

    accounts.each do |account|
      @client.get_recent_tweets(account).each do |tweet|
        begin
          created_tweet = Tweet.create({twitter_account_id: account.id, text: tweet.text, status_id:  tweet.id, published_at: tweet.created_at})

          if tweet.media?
            tweet.media.select{|media| media.class == Twitter::Media::Photo}.each do |photo|
              Picture.create({tweet_id: created_tweet.id, url: photo.media_url.to_s, published_at: tweet.created_at})
            end
          end
        rescue => e
          p e
          p "failed import #{account.screen_name}'s tweet"
        end
      end
    end
  end
end
