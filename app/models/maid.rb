class Maid < ActiveRecord::Base
  validates :name, presence: true
end
