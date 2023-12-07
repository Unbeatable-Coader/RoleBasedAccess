class RemovesColumn < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :encrypted_password
    remove_column :users, :reset_password_token
  end
end
