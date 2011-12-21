# encoding: utf-8

class AddSrpmIdToAclModel < ActiveRecord::Migration
  def change
    add_column :acls, :srpm_id, :integer
    add_index :acls, :srpm_id
    remove_index :acls, :package
    remove_column :acls, :package
  end
end
