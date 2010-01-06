class AddGroupToSrpms < ActiveRecord::Migration
  def self.up
    add_column :srpms, :group, :string
  end

  def self.down
    remove_column :srpms, :group
  end
end
