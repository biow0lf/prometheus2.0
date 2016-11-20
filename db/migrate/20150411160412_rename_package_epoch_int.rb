class RenamePackageEpochInt < ActiveRecord::Migration[4.2]
  def change
    rename_column :packages, :epoch_int, :epoch
  end
end
