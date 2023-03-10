class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :tasks, through: :taggings
  scope :tag_search, -> (tag_id)  { find_by(id: tag_id) }
end