class TwitterAccount < ActiveRecord::Base
  validates :maid_id, presence: true
  validates :uid, presence: true, uniqueness: true
  validates :screen_name, presence: true, uniqueness: true
  validates :maid_id, presence: true

  belongs_to :maid
  has_many :tweets
end
