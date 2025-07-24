class CreateFollows < ActiveRecord::Migration[8.0]
  def change
    create_table :follows do |t|
      t.references :sender, null: false, foreign_key: { to_table: :users }
      t.references :receiver, null: false, foreign_key: { to_table: :users }
      t.boolean :accepted, default: false

      t.timestamps
    end

    add_index :follows, [ :sender_id, :receiver_id ], unique: true
  end
end
