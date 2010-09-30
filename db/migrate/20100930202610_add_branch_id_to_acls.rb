class AddBranchIdToAcls < ActiveRecord::Migration
  def self.up
    add_column :acls, :branch_id, :integer
  end

  def self.down
    remove_column :acls, :branch_id
  end
end