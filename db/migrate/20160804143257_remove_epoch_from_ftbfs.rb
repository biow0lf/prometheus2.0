class RemoveEpochFromFtbfs < ActiveRecord::Migration[5.0]
  def change
    remove_column :ftbfs, :epoch, :string
  end
end
