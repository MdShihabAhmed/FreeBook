class AddParentToComment < ActiveRecord::Migration[8.0]
  def change
    add_column :comments, :parent_id, :integer, null: true
    add_index :comments, :parent_id
  end
end
