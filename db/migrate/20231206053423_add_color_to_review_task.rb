class AddColorToReviewTask < ActiveRecord::Migration[7.1]
  def change
    add_column :review_tasks, :color, :string
  end
end
