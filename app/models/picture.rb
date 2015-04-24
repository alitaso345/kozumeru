class Picture < ActiveRecord::Base
  validates :tweet_id, presence: true
  validates :url, presence: true, uniqueness: true

  belongs_to :tweet

  enum kind: {serve: 0, maid: 1, other: 3}

  def picture_analyzing
    pic = Picture.find_by(:id => id)
    pic.update(:analyzed => true)
  end

  def face_judging(id)
    api = DocomoAPI.new
    pic = Picture.where(:id => id).first
    #if api.face_judgiment(pic.url)
    pic.update_attribute(:kind, 'maid')
    #end
  end


end
