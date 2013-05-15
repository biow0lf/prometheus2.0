class RenameGitrepoModelToGearModel < ActiveRecord::Migration
  def change
    rename_table :gitrepos, :gears
  end
end
