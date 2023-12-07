class AddColumnsToReviewTask < ActiveRecord::Migration[7.1]
  def change
    add_column :review_tasks, :manager_id, :string
    add_column :review_tasks, :assign_to, :string
    add_column :review_tasks, :admin_id, :string
  end
end
