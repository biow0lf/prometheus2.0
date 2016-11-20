class CleanTeamModel < ActiveRecord::Migration[4.2]
  def change
    remove_column :teams, :branch
    remove_column :teams, :vendor
  end
end
