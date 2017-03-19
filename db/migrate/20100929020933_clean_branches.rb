class CleanBranches < ActiveRecord::Migration[4.2]
  def change
    remove_column :branches, :binary_x86_path, :string
    remove_column :branches, :noarch_path, :string
    remove_column :branches, :binary_x86_64_path, :string
    remove_column :branches, :acls_groups_url, :string
  end
end
