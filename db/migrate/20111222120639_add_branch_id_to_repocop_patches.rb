class AddBranchIdToRepocopPatches < ActiveRecord::Migration[4.2]
  def change
    add_column :repocop_patches, :branch_id, :integer
  end
end
