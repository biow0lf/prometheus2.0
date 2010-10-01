class AddBranchIdToLeaders < ActiveRecord::Migration
  def self.up
    add_column :leaders, :branch_id, :integer
  end

  def self.down
    remove_column :leaders, :branch_id
  end
end