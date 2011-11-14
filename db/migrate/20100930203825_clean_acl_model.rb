# encoding: utf-8

class CleanAclModel < ActiveRecord::Migration
  def up
    remove_column :acls, :vendor
    remove_column :acls, :branch
  end

  def down
    add_column :acls, :vendor, :string
    add_column :acls, :branch, :string
  end
end
