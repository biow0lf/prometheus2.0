class AddGroupIdToSrpms < ActiveRecord::Migration
  def up
    add_column :srpms, :group_id, :integer
  end

  def down
    remove_column :srpms, :group_id
  end
end