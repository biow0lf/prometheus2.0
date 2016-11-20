class AddBranchIdToSrpms < ActiveRecord::Migration[4.2]
  def change
    add_column :srpms, :branch_id, :integer
  end
end
