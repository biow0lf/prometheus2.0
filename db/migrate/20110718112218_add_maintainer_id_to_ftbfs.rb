class AddMaintainerIdToFtbfs < ActiveRecord::Migration[4.2]
  def change
    add_column :ftbfs, :maintainer_id, :integer
  end
end
