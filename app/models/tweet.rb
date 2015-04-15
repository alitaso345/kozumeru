class Tweet < ActiveRecord::Base
  validates :twitter_account_id, presence: true
  validates :text, presence: true
  validates :status_id, presence: true, uniqueness: true
  validates :published_at, presence: true

  belongs_to :twitter_account
  has_many :picture

end
