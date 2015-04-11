class RenameSrpmEpochInt < ActiveRecord::Migration
  def change
    rename_column :srpms, :epoch_int, :epoch
  end
end
