# encoding: utf-8

class RemoveAclsUrlFromBranches < ActiveRecord::Migration
  def up
    remove_column :branches, :acls_url
  end

  def down
    add_column :branches, :acls_url, :string
  end
end
