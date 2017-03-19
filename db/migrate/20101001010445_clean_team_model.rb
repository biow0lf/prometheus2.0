class CleanTeamModel < ActiveRecord::Migration[4.2]
  def change
    remove_column :teams, :branch, :string
    remove_column :teams, :vendor, :string
  end
end
