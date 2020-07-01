class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true
  enum status: { 未着手: 0, 着手中: 1, 完了: 2 }
  enum priority: { 低: 0, 中: 1, 高: 2 }
  scope :title_search, ->(search_title) { where("title LIKE ?", "%#{search_title}%") }
  scope :status_search, ->(search_status) { where(status: search_status) }
  belongs_to :user
end
