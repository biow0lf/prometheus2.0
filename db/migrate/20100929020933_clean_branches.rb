class CleanBranches < ActiveRecord::Migration
  def up
    remove_column :branches, :binary_x86_path
    remove_column :branches, :noarch_path
    remove_column :branches, :binary_x86_64_path
    remove_column :branches, :acls_groups_url
  end

  def down
    add_column :branches, :binary_x86_path, :string
    add_column :branches, :noarch_path, :string
    add_column :branches, :binary_x86_64_path, :string
    add_column :branches, :acls_groups_url, :string
  end
end