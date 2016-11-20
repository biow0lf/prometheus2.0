class RenamePackagerTableToMaintainerTable < ActiveRecord::Migration[4.2]
  def change
    rename_table :packagers, :maintainers
  end
end
