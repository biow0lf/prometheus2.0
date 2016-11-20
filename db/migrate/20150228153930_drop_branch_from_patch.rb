class DropBranchFromPatch < ActiveRecord::Migration[4.2]
  def change
    remove_index :patches, :branch_id
    remove_column :patches, :branch_id
  end
end
