class Picture < ActiveRecord::Base
  validates :tweet_id, presence: true
  validates :url, presence: true, uniqueness: true

  belongs_to :tweet
  belongs_to :post

  enum kind: {serve: 0, maid: 1, other: 3}
end
