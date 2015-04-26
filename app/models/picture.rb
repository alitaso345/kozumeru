class Picture < ActiveRecord::Base
  validates :url, presence: true, uniqueness: true

  belongs_to :tweet
  belongs_to :post

  enum kind: {serve: 0, maid: 1, other: 2}
end
