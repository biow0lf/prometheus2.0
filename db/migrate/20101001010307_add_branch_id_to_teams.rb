class AddBranchIdToTeams < ActiveRecord::Migration
  def self.up
    add_column :teams, :branch_id, :integer
  end

  def self.down
    remove_column :teams, :branch_id
  end
end