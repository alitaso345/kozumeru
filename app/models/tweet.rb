class Tweet < ActiveRecord::Base
  validates :twitter_account_id, presence: true
  validates :text, presence: true
  validates :status_id, presence: true
  validates :published_at, presence

  belongs_to :twitter_account
  has_many :pictures
end
