class Tag < ApplicationRecord
  validates :title, presence: true, length: { maximum: 30 }
  has_many :taggings, dependent: :destroy
  has_many :tagging_tasks, through: :taggings, source: :task
end
