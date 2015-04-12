class Tweet < ActiveRecord::Base
  validates :twitter_account_id, presence: true
  validates :text, presence: true
  validates :status_id, presence: true, uniqueness: true
  validates :published_at, presence: true

  belongs_to :twitter_account
  has_many :pictures

  def self.import_recent_tweet
    accounts = TwitterAccount.all.select('id, screen_name')
    client = TwitterClient.new

    accounts.each do |account|
      begin
        client.get_recent_tweets(account).each do |tweet|
          tw = Tweet.create({twitter_account_id: account.id, text: tweet.text, status_id:  tweet.id, published_at: tweet.created_at})

          if has_media?(tweet)
            Picture.create({tweet_id: tw.id, url: tweet.media.first.media_url})
          end
        end
      rescue => e
        p e
        p "failed import #{account.screen_name}'s tweet"
      end
    end
  end

  private
  def self.has_media?(tweet)
    (tweet.media? && tweet.media.first.media_url) ? true : false
  end
end
