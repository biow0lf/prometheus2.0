class RenamePackagerIdToMaintainerIdInLeaderModel < ActiveRecord::Migration
  def up
    remove_index :leaders, :packager_id
    rename_column :leaders, :packager_id, :maintainer_id
    add_index :leaders, :maintainer_id
  end

  def down
    remove_index :leaders, :maintainer_id
    rename_column :leaders, :maintainer_id, :packager_id
    add_index :leaders, :packager_id
  end
end