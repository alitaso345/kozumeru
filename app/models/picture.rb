class Picture < ActiveRecord::Base
  validates :tweet_id, presence: true
  validates :url, presence: true, uniqueness: true

  belongs_to :tweet
  belongs_to :post

  enum kind: {serve: 0, maid: 1, other: 3}

  def analyze
    self.face_analyzing
    self.update(:analyzed => true)
    self.save!
  end

  def face_analyzing
    api = DocomoAPI.new
    self.update(:kind => 'maid') if api.face_judgement(self.url)
    self.save!
  end


end
