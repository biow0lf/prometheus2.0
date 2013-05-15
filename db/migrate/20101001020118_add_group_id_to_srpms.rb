class AddGroupIdToSrpms < ActiveRecord::Migration
  def change
    add_column :srpms, :group_id, :integer
  end
end
