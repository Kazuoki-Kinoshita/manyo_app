class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :tagging_tasks, through: :taggings, source: :task
end