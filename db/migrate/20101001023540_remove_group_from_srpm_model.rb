class RemoveGroupFromSrpmModel < ActiveRecord::Migration
  def self.up
    remove_column :srpms, :group
  end

  def self.down
    add_column :srpms, :group, :string
  end
end