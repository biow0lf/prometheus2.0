class CleanBranches < ActiveRecord::Migration[4.2]
  def change
    remove_column :branches, :binary_x86_path
    remove_column :branches, :noarch_path
    remove_column :branches, :binary_x86_64_path
    remove_column :branches, :acls_groups_url
  end
end
