class AddBranchIdToGroups < ActiveRecord::Migration
  def self.up
    add_column :groups, :branch_id, :integer
  end

  def self.down
    remove_column :groups, :branch_id
  end
end