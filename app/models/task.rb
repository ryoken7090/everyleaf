class Task < ApplicationRecord
  validates :title, presence: true, { maximum: 100 }
  validates :content, presence: true
end
