class RemovePackageEpoch < ActiveRecord::Migration
  def change
    remove_column :packages, :epoch
  end
end
