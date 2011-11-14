# encoding: utf-8

class RenamePackagerTableToMaintainerTable < ActiveRecord::Migration
  def up
    rename_table :packagers, :maintainers
  end

  def down
    rename_table :maintainers, :packagers
  end
end
