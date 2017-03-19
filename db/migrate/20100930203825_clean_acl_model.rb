class CleanAclModel < ActiveRecord::Migration[4.2]
  def change
    remove_column :acls, :vendor, :string
    remove_column :acls, :branch, :string
  end
end
