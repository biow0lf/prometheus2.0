class AddGroupIdToPackageModel < ActiveRecord::Migration
  def change
    add_column :packages, :group_id, :integer
    add_index :packages, :group_id
    remove_column :packages, :group
  end
end
