class AddConnectionTokenToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :connection_token, :string
  end
end
