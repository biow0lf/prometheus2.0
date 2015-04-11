class AddSrpmEpochInt < ActiveRecord::Migration
  def change
    add_column :srpms, :epoch_int, :integer
  end
end
