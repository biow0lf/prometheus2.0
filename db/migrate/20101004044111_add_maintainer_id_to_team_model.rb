class AddMaintainerIdToTeamModel < ActiveRecord::Migration
  def self.up
    add_column :teams, :maintainer_id, :integer
    add_index :teams, :maintainer_id
    remove_column :teams, :login
  end

  def self.down
    add_column :teams, :login, :string
    remove_index :teams, :maintainer_id
    remove_column :teams, :maintainer_id
  end
end