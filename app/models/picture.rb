class Picture < ActiveRecord::Base
  validates :tweet_id, presence: true
  validates :url, presence: true, uniqueness: true

  belongs_to :tweet

  enum kind: {serve: 0, maid: 1, other: 3}

  def picture_analyzing(id)
    pic = Picture.find_by(:id => id)
    pic.face_judging(id)
    pic.update(:analyzed => true)
    pic.save!
  end

  def face_judging(id)
    api = DocomoAPI.new
    pic = Picture.find_by(:id => id)
    pic.update(:kind => 'maid') #if api.face_judgiment(pic.url)
  end


end
