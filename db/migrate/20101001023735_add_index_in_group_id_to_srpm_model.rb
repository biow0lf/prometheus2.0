class AddIndexInGroupIdToSrpmModel < ActiveRecord::Migration[4.2]
  def change
    add_index :srpms, :group_id
  end
end
