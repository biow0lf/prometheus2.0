class DropBranchFromPatch < ActiveRecord::Migration
  def change
    remove_index :patches, :branch_id
    remove_column :patches, :branch_id
  end
end
