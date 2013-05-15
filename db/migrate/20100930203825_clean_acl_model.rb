class CleanAclModel < ActiveRecord::Migration
  def change
    remove_column :acls, :vendor
    remove_column :acls, :branch
  end
end
