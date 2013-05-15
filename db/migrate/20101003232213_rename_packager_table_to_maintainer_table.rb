class RenamePackagerTableToMaintainerTable < ActiveRecord::Migration
  def change
    rename_table :packagers, :maintainers
  end
end
