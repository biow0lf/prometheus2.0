class AddIndexInGroupIdToSrpmModel < ActiveRecord::Migration
  def up
    add_index :srpms, :group_id
  end

  def down
    remove_index :srpms, :group_id
  end
end