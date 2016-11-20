class RenameSrpmEpochInt < ActiveRecord::Migration[4.2]
  def change
    rename_column :srpms, :epoch_int, :epoch
  end
end
