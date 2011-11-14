# encoding: utf-8

class AddBranchIdToTeams < ActiveRecord::Migration
  def up
    add_column :teams, :branch_id, :integer
  end

  def down
    remove_column :teams, :branch_id
  end
end
