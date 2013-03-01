class AddGroupnameToSrpms < ActiveRecord::Migration
  def change
    add_column :srpms, :groupname, :string
  end
end
