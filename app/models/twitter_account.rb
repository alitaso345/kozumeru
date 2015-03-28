class TwitterAccount < ActiveRecord::Base
  validates :uid, presence: true
  validates :username, presence: true
  validates :maid_id, presence: true

  belongs_to :maid
end
