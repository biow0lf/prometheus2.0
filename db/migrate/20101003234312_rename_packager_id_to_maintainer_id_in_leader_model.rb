class RenamePackagerIdToMaintainerIdInLeaderModel < ActiveRecord::Migration
  def change
    remove_index :leaders, :packager_id
    rename_column :leaders, :packager_id, :maintainer_id
    add_index :leaders, :maintainer_id
  end
end
