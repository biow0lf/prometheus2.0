class AddPackageEpochInt < ActiveRecord::Migration[4.2]
  def change
    add_column :packages, :epoch_int, :integer
  end
end
