class AddMaintainerIdToFtbfs < ActiveRecord::Migration
  def self.up
    add_column :ftbfs, :maintainer_id, :integer
  end

  def self.down
    remove_column :ftbfs, :maintainer_id
  end
end
