class RemoveTeamsFromMaintainers < ActiveRecord::Migration
  def change
    remove_column :maintainers, :team
  end
end
