# encoding: utf-8

class AddBranchIdToPackages < ActiveRecord::Migration
  def up
    add_column :packages, :branch_id, :integer
  end

  def down
    remove_column :packages, :branch_id
  end
end
