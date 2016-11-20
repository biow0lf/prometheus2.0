class AddGroupnameToSrpms < ActiveRecord::Migration[4.2]
  def change
    add_column :srpms, :groupname, :string
  end
end
