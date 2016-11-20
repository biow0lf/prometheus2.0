class AddMaintainerIdToTeamModel < ActiveRecord::Migration[4.2]
  def change
    add_column :teams, :maintainer_id, :integer
    add_index :teams, :maintainer_id
    remove_column :teams, :login
  end
end
