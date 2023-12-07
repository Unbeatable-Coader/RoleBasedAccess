class AddadminIdToTasks < ActiveRecord::Migration[7.1]
  def change
    add_column :tasks, :admin_id, :string
  end
end
