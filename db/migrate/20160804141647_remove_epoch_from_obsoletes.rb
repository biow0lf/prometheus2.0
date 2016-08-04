class RemoveEpochFromObsoletes < ActiveRecord::Migration[5.0]
  def change
    remove_column :obsoletes, :epoch, :string
  end
end
