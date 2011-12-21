# encoding: utf-8

class RenamePackagerTableToMaintainerTable < ActiveRecord::Migration
  def change
    rename_table :packagers, :maintainers
  end
end
