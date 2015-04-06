class Picture < ActiveRecord::Base
  validates :tweet_id, presence: true
  validates :url, presence: true, uniqueness: true

  belongs_to :tweet
end
