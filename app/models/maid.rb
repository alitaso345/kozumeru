class Maid < ActiveRecord::Base
  validates :name, presence: true
  validates :number, presence: true, uniqueness: true

  has_one :twitter_account
  has_one :blog

  def tweets
    self.twitter_account.tweets.order('published_at DESC')
  end

  def pictures(params)
    ids = []
    tweets = self.twitter_account.tweets.order('published_at DESC')
    tweets.select{|tweet| tweet.pictures}.map do |tweet|
      tweet.pictures.each{|pic| ids << pic.id}
    end
 
    options = params.merge({id: ids})
    Picture.where(options)
  end

  def self.import_info_from_homepage
    lists = HomePageCrawler.get_maid_lists
    client = TwitterClient.new
    lists.each do |list|
      begin
        maid = Maid.create(name: list[:name], floor: list[:floor], number: list[:number])
        if list[:screen_name]
          TwitterAccount.create(uid: client.user_uid(list[:screen_name]), screen_name: list[:screen_name], maid_id: maid.id)
        end

        Blog.import_info(maid, list[:blog_url])

      rescue => e
        p e
        p "#{list[:name]} failed import data"
      end
    end
  end
end
