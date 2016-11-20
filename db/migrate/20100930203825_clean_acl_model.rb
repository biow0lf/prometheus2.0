class CleanAclModel < ActiveRecord::Migration[4.2]
  def change
    remove_column :acls, :vendor
    remove_column :acls, :branch
  end
end
