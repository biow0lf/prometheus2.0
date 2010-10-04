class AddSrpmIdToAclModel < ActiveRecord::Migration
  def self.up
    add_column :acls, :srpm_id, :integer
    add_index :acls, :srpm_id
    remove_index :acls, :package
    remove_column :acls, :package
  end

  def self.down
    add_column :acls, :package, :string
    add_index :acls, :package
    remove_index :acls, :srpm_id
    remove_column :acls, :srpm_id
  end
end