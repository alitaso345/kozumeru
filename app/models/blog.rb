class Blog < ActiveRecord::Base
  validates :title, presence: true
  validates :url, presence: true, uniqueness: true

  belongs_to :maid
  has_many :posts
end
