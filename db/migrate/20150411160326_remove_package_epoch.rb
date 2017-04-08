class RemovePackageEpoch < ActiveRecord::Migration[4.2]
  def change
    remove_column :packages, :epoch, :string
  end
end
