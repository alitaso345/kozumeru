class ServingDay < ActiveRecord::Base
  validates :maid_id, presence: true
  validates :picture_id, presence: true
  validates :location, presence: true

  belongs_to :maid
  belongs_to :pictures

  enum location: {undecided: 0, fourth_floor: 4, fifth_floor: 5, sixth_floor: 6, seventh_floor: 7, donki_floor: 10}
end
