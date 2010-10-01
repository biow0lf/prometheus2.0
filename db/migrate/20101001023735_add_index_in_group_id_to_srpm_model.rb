class AddIndexInGroupIdToSrpmModel < ActiveRecord::Migration
  def self.up
    add_index :srpms, :group_id
  end

  def self.down
    remove_index :srpms, :group_id
  end
end