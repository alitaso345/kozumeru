class TwitterClient
  def initialize
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.secrets[:twitter_api_key]
      config.consumer_secret     = Rails.application.secrets[:twitter_api_secret]
      config.access_token        = Rails.application.secrets[:twitter_api_access_token]
      config.access_token_secret = Rails.application.secrets[:twitter_api_access_token_secret]
    end
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

  def get_user_uid(screen_name)
    @client.user(screen_name).id.to_s
  end
end