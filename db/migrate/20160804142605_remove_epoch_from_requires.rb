class RemoveEpochFromRequires < ActiveRecord::Migration[5.0]
  def change
    remove_column :requires, :epoch, :string
  end
end
