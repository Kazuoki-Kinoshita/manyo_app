class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true, length: { maximum: 300 }
  validates :expired_at, presence: true
  validates :status, presence: true
  enum status: { 未着手: 0, 着手中: 1, 完了: 2}
  scope :title_and_status_search, -> (params) { where("title LIKE ?", "%#{params[:task][:title]}%").where(status: params[:task][:status]) }
  scope :title_search, -> (params)  { where("title LIKE ?", "%#{params[:task][:title]}%") }
  scope :status_search, -> (params)  { where(status: params[:task][:status]) }
end