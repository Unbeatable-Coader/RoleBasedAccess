class AddstatusToReviewTask < ActiveRecord::Migration[7.1]
  def change
    add_column :review_tasks, :status, :string
  end
end
