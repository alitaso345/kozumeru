class Blog < ActiveRecord::Base
  validates :title, presence: true
  validates :url, presence: true, uniqueness: true

  belongs_to :maid
  has_many :posts

  def self.import_info(maid, url)
    if url
      info = HomePageCrawler.blog_detail(url)
      self.create(maid_id: maid.id, title: info[:title], account_name: info[:account_name])
    end
  end
end
