class RenameGitrepoModelToGearModel < ActiveRecord::Migration
  def up
    rename_table :gitrepos, :gears
  end

  def down
    rename_table :gears, :gitrepos
  end
end
