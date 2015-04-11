class AddPackageEpochInt < ActiveRecord::Migration
  def change
    add_column :packages, :epoch_int, :integer
  end
end
