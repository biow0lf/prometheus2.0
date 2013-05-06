class AddIndexesToAcls < ActiveRecord::Migration
  def change
    add_index :acls, :branch
    add_index :acls, :vendor
    add_index :acls, :package
    add_index :acls, :login
  end
end
