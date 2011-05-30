class RenameGitrepoModelToGearModel < ActiveRecord::Migration
  def self.up
    rename_table :gitrepos, :gears
  end

  def self.down
    rename_table :gears, :gitrepos
  end
end
