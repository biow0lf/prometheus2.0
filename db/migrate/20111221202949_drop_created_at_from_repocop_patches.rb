class DropCreatedAtFromRepocopPatches < ActiveRecord::Migration[4.2]
  def change
    remove_column :repocop_patches, :created_at
    remove_column :repocop_patches, :updated_at
  end
end
