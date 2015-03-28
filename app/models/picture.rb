class Picture < ActiveRecord::Base
  validates :tweet_id, presence: true
  validates :url, presence: true

  belongs_to :tweet
end
