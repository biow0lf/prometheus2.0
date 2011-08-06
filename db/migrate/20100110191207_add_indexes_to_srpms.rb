class AddIndexesToSrpms < ActiveRecord::Migration
  def up
    add_index :srpms, :name
  end

  def down
    remove_index :srpms, :name
  end
end
