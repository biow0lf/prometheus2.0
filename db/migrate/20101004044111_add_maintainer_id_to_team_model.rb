# encoding: utf-8

class AddMaintainerIdToTeamModel < ActiveRecord::Migration
  def change
    add_column :teams, :maintainer_id, :integer
    add_index :teams, :maintainer_id
    remove_column :teams, :login
  end
end
