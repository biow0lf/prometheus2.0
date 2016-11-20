class AddGroupIdToPackageModel < ActiveRecord::Migration[4.2]
  def change
    add_column :packages, :group_id, :integer
    add_index :packages, :group_id
    remove_column :packages, :group
  end
end
