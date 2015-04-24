class Picture < ActiveRecord::Base
  validates :tweet_id, presence: true
  validates :url, presence: true, uniqueness: true

  belongs_to :tweet

  enum kind: {serve: 0, maid: 1, other: 3}

  def picture_analizing
    pic =  Picture.where(:id => id).first
    pic.update_attribute(:analized, true)
  end

end
