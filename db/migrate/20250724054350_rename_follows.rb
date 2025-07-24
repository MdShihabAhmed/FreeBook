class RenameFollows < ActiveRecord::Migration[8.0]
  def change
    rename_table :follows, :follow_requests
  end
end
