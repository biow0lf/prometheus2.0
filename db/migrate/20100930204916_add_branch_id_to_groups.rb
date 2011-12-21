# encoding: utf-8

class AddBranchIdToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :branch_id, :integer
  end
end
