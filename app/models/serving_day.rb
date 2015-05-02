class ServingDay < ActiveRecord::Base
  validates :maid_id, presence: true
  validates :picture_id, presence: true
  validates :location, presence: true

  belongs_to :maid
  belongs_to :pictures

  enum location: {undecided: 0, fourth_floor: 4, fifth_floor: 5, sixth_floor: 6, seventh_floor: 7, donki_floor: 10}


  def location=(text)
    write_attribute(:location, which_location(text))
  end

  def which_location(text)
    case text
    when "本店4階"
      4
    when "おもてなし"
      5
    when "本店6階"
      6
    when "本店7階"
      7
    when "ドンキ店"
      10
    else
      9
    end
  end
end
