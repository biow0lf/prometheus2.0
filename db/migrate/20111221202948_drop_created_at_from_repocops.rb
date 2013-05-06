class DropCreatedAtFromRepocops < ActiveRecord::Migration
  def change
    remove_column :repocops, :created_at
    remove_column :repocops, :updated_at
  end
end
