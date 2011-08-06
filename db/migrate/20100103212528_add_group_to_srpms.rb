class AddGroupToSrpms < ActiveRecord::Migration
  def up
    add_column :srpms, :group, :string
  end

  def down
    remove_column :srpms, :group
  end
end
