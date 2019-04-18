class RemoveConnectionTokenFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :connection_token, :string
  end
end
