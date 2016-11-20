class AddGroupnameToPackages < ActiveRecord::Migration[4.2]
  def change
    add_column :packages, :groupname, :string
  end
end
