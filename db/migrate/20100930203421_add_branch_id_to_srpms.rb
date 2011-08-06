class AddBranchIdToSrpms < ActiveRecord::Migration
  def up
    add_column :srpms, :branch_id, :integer
  end

  def down
    remove_column :srpms, :branch_id
  end
end