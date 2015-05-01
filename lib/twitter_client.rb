class TwitterClient
  def initialize
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.secrets[:twitter_api_key]
      config.consumer_secret     = Rails.application.secrets[:twitter_api_secret]
      config.access_token        = Rails.application.secrets[:twitter_api_access_token]
      config.access_token_secret = Rails.application.secrets[:twitter_api_access_token_secret]
    end

    @default_options = {exclude_replies: true, include_rts: false}
  end

  def get_recent_tweets(user)
    options = @default_options
    if user.tweets.last
      options[:since_id] = user.tweets.last.id.to_i
    else
      options[:count] = 1
    end

    begin
      @client.user_timeline(user.screen_name, options)
    rescue => e
      p e
    end
  end

  def get_seed_tweets
    p "Start getting tweets..."

    TwitterAccount.all.each do |account|
      begin
        tweets = @client.user_timeline(account.screen_name, {count: 1})
        tweets.each do |tweet|
          Tweet.create(twitter_account_id: account.id, text: tweet.text, status_id: tweet.id, published_at: tweet.created_at)
        end
      rescue => e
        p account
        p e
      end
    end
    p "Done..."
  end

  def get_all_tweets(user)
    collect_with_max_id do |max_id|
      options = {count: 200, include_rts: true}
      options[:max_id] = max_id unless max_id.nil?
      @client.user_timeline(user, options)
    end
  end

  def collect_with_max_id(collection=[], max_id=nil, &block)
    response = yield(max_id)
    collection += response
    response.empty? ? collection.flatten : collect_with_max_id(collection, response.last.id - 1, &block)
  end

  def user_uid(screen_name)
    @client.user(screen_name).id.to_s
  end
end
