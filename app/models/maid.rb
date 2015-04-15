class Maid < ActiveRecord::Base
  validates :name, presence: true
  validates :number, presence: true, uniqueness: true

  has_one :twitter_account

  #所属する階を示すフラグ
  GRADUATED 0
  NEW_COMER 1
  PREMIUM 2
  FOURTH_FLOOR 3
  SIXTH_FLOOR 4
  SEVENTH_FLOOR 5
  DONKI 6

  def tweets
    self.twitter_account.tweets
  end

  def pictures
    self.twitter_account.tweets.select{|tweet| tweet.picture}.map do |tweet|
      tweet.picture
    end
  end

  def self.import_info_from_homepage
    lists = HomePageCrawler.get_maid_lists
    client = TwitterClient.new
    lists.each do |list|
      begin
        maid = Maid.create(name: list[:name], floor: list[:floor], number: list[:number])
        if list[:screen_name]
          TwitterAccount.create(uid: client.get_user_uid(list[:screen_name]), screen_name: list[:screen_name], maid_id: maid.id)
        end
      rescue => e
        p e
        p "#{list[:name]} failed import data"
      end
    end
  end
end
