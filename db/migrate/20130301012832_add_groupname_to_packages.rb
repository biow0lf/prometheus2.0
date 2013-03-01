class AddGroupnameToPackages < ActiveRecord::Migration
  def change
    add_column :packages, :groupname, :string
  end
end
