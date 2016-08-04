class AddEpochToConflicts < ActiveRecord::Migration[5.0]
  def change
    add_column :conflicts, :epoch, :integer
  end
end
