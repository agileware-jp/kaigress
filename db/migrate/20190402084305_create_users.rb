class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :nickname
      t.string :uuid
      t.integer :team

      t.timestamps
    end
    add_index :users, :uuid, unique: true
  end
end
