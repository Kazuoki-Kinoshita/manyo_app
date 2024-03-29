class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true, length: { maximum: 300 }
  validates :expired_at, presence: true
  validates :status, presence: true
  validates :priority, presence: true

  enum status: { 未着手: 0, 着手中: 1, 完了: 2}
  enum priority: { 低: 0, 中: 1, 高: 2}
  
  belongs_to :user
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  
  scope :created_at_sorted, -> { order(created_at: :desc) }
  scope :expired_at_sorted, -> { order(expired_at: :desc) }
  scope :priority_sorted, -> { order(priority: :desc) }
  scope :title_and_status_current_user_search, -> (title, status, current_user_id) { where("title LIKE ?", "%#{ title }%").where(status: status).where(user_id: current_user_id) }
  scope :title_current_user_search, -> (title, current_user_id) { where("title LIKE ?", "%#{ title }%").where(user_id: current_user_id) }
  scope :status_current_user_search, -> (status, current_user_id) { where(status: status).where(user_id: current_user_id) }
  scope :title_and_status_search, -> (title, status) { where("title LIKE ?", "%#{title}%").where(status: status) }
  scope :title_search, -> (title)  { where("title LIKE ?", "%#{title}%") }
  scope :status_search, -> (status)  { where(status: status) }
  scope :tag_search, -> (current_user_id)  { where(user_id: current_user_id) }
end