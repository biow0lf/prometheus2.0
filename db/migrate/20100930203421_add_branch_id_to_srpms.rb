# encoding: utf-8

class AddBranchIdToSrpms < ActiveRecord::Migration
  def change
    add_column :srpms, :branch_id, :integer
  end
end
