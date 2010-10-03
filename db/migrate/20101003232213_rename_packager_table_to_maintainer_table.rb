class RenamePackagerTableToMaintainerTable < ActiveRecord::Migration
  def self.up
    rename_table :packagers, :maintainers
  end

  def self.down
    rename_table :maintainers, :packagers
  end
end