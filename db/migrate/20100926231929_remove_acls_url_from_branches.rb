class RemoveAclsUrlFromBranches < ActiveRecord::Migration[4.2]
  def change
    remove_column :branches, :acls_url
  end
end
