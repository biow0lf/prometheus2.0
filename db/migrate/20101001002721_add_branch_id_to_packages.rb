class AddBranchIdToPackages < ActiveRecord::Migration
  def self.up
    add_column :packages, :branch_id, :integer
  end

  def self.down
    remove_column :packages, :branch_id
  end
end