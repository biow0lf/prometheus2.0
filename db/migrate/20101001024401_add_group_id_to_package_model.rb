class AddGroupIdToPackageModel < ActiveRecord::Migration
  def self.up
    add_column :packages, :group_id, :integer
    add_index :packages, :group_id
    remove_column :packages, :group
  end

  def self.down
    remove_index :packages, :group_id
    remove_column :packages, :group_id
    add_column :packages, :group, :string
  end
end