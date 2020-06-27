class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true
  enum status: { yet: 0, working: 1, completed: 2 }

  scope :search, ->(search_title) { where("title LIKE ?", "%#{search_title}%") }
end
