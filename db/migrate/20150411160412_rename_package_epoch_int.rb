class RenamePackageEpochInt < ActiveRecord::Migration
  def change
    rename_column :packages, :epoch_int, :epoch
  end
end
