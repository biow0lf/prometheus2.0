class RenamePackagerIdToMaintainerIdInLeaderModel < ActiveRecord::Migration
  def self.up
    remove_index :leaders, :packager_id
    rename_column :leaders, :packager_id, :maintainer_id
    add_index :leaders, :maintainer_id
  end

  def self.down
    remove_index :leaders, :maintainer_id
    rename_column :leaders, :maintainer_id, :packager_id
    add_index :leaders, :packager_id
  end
end