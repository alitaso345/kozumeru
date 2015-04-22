class ServingDay < ActiveRecord::Base
  validates :maid_id, presence: true
  validates :picture_id, presence: true
  validates :location, presence: true

end
