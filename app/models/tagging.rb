class Tagging < ApplicationRecord
  belongs_to :task
  belongs_to :tag
  scope :tag_search, ->(search_tag) { where(tag_id: search_tag) }

end
