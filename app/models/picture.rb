class Picture < ActiveRecord::Base
  validates :tweet_id, presence: true
  validates :url, presence: true, uniqueness: true

  belongs_to :tweet
  belongs_to :post

  enum kind: {serve: 0, maid: 1, other: 3}

  def picture_analyzing
    self.face_judging
    self.update(:analyzed => true)
    self.save!
  end

  def face_judging
    api = DocomoAPI.new
    self.update(:kind => 'maid') if api.face_judgement(self.url)
    self.save!
  end


end
