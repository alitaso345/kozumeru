class Picture < ActiveRecord::Base
  validates :tweet_id, presence: true
  validates :url, presence: true, uniqueness: true

  belongs_to :tweet
  belongs_to :post

  enum kind: {serve: 0, maid: 1, other: 3}

  def picture_analyzing
    @api = DocomoAPI.new
    self.doc_analyzing
    self.face_analyzing
    self.update(:analyzed => true)
    self.save!
  end

  def doc_analyzing
    self.update(:kind => 'serve') if @api.doc_judgement(self.url)
    self.save!
  end

  def face_analyzing
    self.update(:kind => 'maid') if @api.face_judgement(self.url)
    self.save!
  end


end
