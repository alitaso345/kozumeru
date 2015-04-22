class ServingDay < ActiveRecord::Base
  validates :maid_id, presence: true
  validates :picture_id, presence: true
  validates :location, presence: true

  belongs_to :maid
  belongs_to :pictures

  enum location: {undecided: 0, fourth_floor: 1, fifth_floor: 2, seventh_floor: 3}
end
