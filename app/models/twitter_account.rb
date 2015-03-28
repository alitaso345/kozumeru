class TwitterAccount < ActiveRecord::Base
  validates :maid_id, presence: true
  validates :uid, presence: true
  validates :username, presence: true
  validates :maid_id, presence: true

  belongs_to :maid
  has_many :tweets
end