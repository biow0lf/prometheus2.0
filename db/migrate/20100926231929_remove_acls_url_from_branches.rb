# encoding: utf-8

class RemoveAclsUrlFromBranches < ActiveRecord::Migration
  def change
    remove_column :branches, :acls_url
  end
end
