class AddMaintainerIdToAclModel < ActiveRecord::Migration
  def self.up
    remove_index :acls, :login
    add_column :acls, :maintainer_id, :integer
    add_index :acls, :maintainer_id
    remove_column :acls, :login
  end

  def self.down
    remove_index :acls, :maintainer_id
    add_column :acls, :login, :string
    add_index :acls, :login
    remove_column :acls, :maintainer_id
  end
end