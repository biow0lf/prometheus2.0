class RemoveEpochFromProvides < ActiveRecord::Migration[5.0]
  def change
    remove_column :provides, :epoch, :string
  end
end
