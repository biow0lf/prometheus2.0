class AddMaintainerIdToAclModel < ActiveRecord::Migration[4.2]
  def change
    remove_index :acls, :login
    add_column :acls, :maintainer_id, :integer
    add_index :acls, :maintainer_id
    remove_column :acls, :login
  end
end
