class CreateTaggings < ActiveRecord::Migration[5.2]
  def change
    create_table :taggings do |t|
      t.integer :task_id
      t.integer :tag_id

      t.timestamps
    end
  end
end
