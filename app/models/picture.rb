class Picture < ActiveRecord::Base
  validates :tweet_id, presence: true
  validates :url, presence: true, uniqueness: true

  belongs_to :tweet
  belongs_to :post

  enum kind: {other: 0, maid: 1, serve: 3}

  def picture_analyzing
    self.face_analyzing
    self.doc_analyzing
    self.update(:analyzed => true)
    self.save!
  end

  def doc_analyzing
    @api = DocomoAPI.new
    self.update(:kind => 'serve') if @api.doc_judgement(self.url)
    self.save!
  end

  def face_analyzing
    @api = DocomoAPI.new
    self.update(:kind => 'maid') if @api.face_judgement(self.url)
    self.save!
  end


end
