class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true
  enum status: { yet: 0, working: 1, completed: 2 }
end
