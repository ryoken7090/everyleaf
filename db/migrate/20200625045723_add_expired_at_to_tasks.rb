class AddExpiredAtToTasks < ActiveRecord::Migration[5.2]
  def up
    add_column :tasks, :expired_at, :datetime, null: false, default: DateTime.now + 7
  end
  def down
    remove_column :tasks, :expired_at
  end
end
