class ServingDay < ActiveRecord::Base
  validates :maid_id, presence: true
  validates :picture_id, presence: true
  validates :location, presence: true

  belongs_to :maid
  belongs_to :pictures
end
