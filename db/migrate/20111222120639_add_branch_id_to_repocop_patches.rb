class AddBranchIdToRepocopPatches < ActiveRecord::Migration
  def change
    add_column :repocop_patches, :branch_id, :integer
  end
end
