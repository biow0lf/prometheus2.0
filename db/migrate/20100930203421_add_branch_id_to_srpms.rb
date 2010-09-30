class AddBranchIdToSrpms < ActiveRecord::Migration
  def self.up
    add_column :srpms, :branch_id, :integer
  end

  def self.down
    remove_column :srpms, :branch_id
  end
end