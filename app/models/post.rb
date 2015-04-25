class Post < ActiveRecord::Base
  validates :url, presence: true, uniqueness: true
  validates :title, presence: true
  validates :body, presence: true
  validates :published_at, presence: true

  belongs_to :blog
  has_many :pictures
end
