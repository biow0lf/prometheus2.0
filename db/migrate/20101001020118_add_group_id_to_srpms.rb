class AddGroupIdToSrpms < ActiveRecord::Migration
  def self.up
    add_column :srpms, :group_id, :integer
  end

  def self.down
    remove_column :srpms, :group_id
  end
end