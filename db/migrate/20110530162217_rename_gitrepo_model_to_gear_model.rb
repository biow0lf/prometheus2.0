class RenameGitrepoModelToGearModel < ActiveRecord::Migration[4.2]
  def change
    rename_table :gitrepos, :gears
  end
end
