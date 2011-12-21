# encoding: utf-8

class AddBranchIdToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :branch_id, :integer
  end
end
