class CreateConnections < ActiveRecord::Migration[5.2]
  def change
    create_table :connections do |t|
      t.references :from, foreign_key: { to_table: 'users' }, null: false
      t.references :to, foreign_key: { to_table: 'users' }, null: false

      t.timestamps
    end
    add_index :connections, [:from_id, :to_id], unique: true
  end
end
