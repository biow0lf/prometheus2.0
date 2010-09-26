class RemoveAclsUrlFromBranches < ActiveRecord::Migration
  def self.up
    remove_column :branches, :acls_url
  end

  def self.down
    add_column :branches, :acls_url, :string
  end
end