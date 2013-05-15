class DropCreatedAtFromRepocopPatches < ActiveRecord::Migration
  def change
    remove_column :repocop_patches, :created_at
    remove_column :repocop_patches, :updated_at
  end
end
