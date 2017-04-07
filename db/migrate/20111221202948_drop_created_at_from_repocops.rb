class DropCreatedAtFromRepocops < ActiveRecord::Migration[4.2]
  def change
    remove_column :repocops, :created_at, :datetime
    remove_column :repocops, :updated_at, :datetime
  end
end
