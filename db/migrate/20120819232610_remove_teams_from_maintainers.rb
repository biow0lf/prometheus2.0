class RemoveTeamsFromMaintainers < ActiveRecord::Migration[4.2]
  def change
    remove_column :maintainers, :team, :boolean
  end
end
