class Blog < ActiveRecord::Base
  validates :title, presence: true
  validates :url, presence: true, uniqueness: true

  belongs_to :maid
end
