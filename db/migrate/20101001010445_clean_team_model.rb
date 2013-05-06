class CleanTeamModel < ActiveRecord::Migration
  def change
    remove_column :teams, :branch
    remove_column :teams, :vendor
  end
end
