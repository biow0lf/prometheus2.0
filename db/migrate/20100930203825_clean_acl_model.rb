class CleanAclModel < ActiveRecord::Migration
  def self.up
    remove_column :acls, :vendor
    remove_column :acls, :branch
  end

  def self.down
    add_column :acls, :vendor, :string
    add_column :acls, :branch, :string
  end
end