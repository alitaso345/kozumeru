class Maid < ActiveRecord::Base
  validates :name, presence: true

  has_one :twitter_account

  def self.import_info_from_homepage
    lists = HomePageCrawler.get_maid_lists
    client = TwitterClient.new
    lists.each do |list|
      begin
        maid = Maid.create(name: list[:name], floor: list[:floor], maidnumber: list[:maid_number])
        TwitterAccount.create(uid: client.get_user_uid(list[:screen_name]), screen_name: list[:screen_name], maid_id: maid.id)
        sleep 0.5 #連続してアクセスしすぎるとAPI制限を食らうため
      rescue => e
        p e
        p "#{list[:name]} failed import data"
      end
    end
  end
end
