class RemoveEpochFromConflicts < ActiveRecord::Migration[5.0]
  def change
    remove_column :conflicts, :epoch, :string
  end
end
