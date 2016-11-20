class DropCreatedAtFromRepocops < ActiveRecord::Migration[4.2]
  def change
    remove_column :repocops, :created_at
    remove_column :repocops, :updated_at
  end
end
