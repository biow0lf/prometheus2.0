class AddSrpmEpochInt < ActiveRecord::Migration[4.2]
  def change
    add_column :srpms, :epoch_int, :integer
  end
end
