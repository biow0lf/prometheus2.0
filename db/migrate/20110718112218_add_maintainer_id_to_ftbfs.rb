class AddMaintainerIdToFtbfs < ActiveRecord::Migration
  def up
    add_column :ftbfs, :maintainer_id, :integer
  end

  def down
    remove_column :ftbfs, :maintainer_id
  end
end
