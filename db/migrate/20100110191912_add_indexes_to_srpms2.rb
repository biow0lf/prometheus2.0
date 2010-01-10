class AddIndexesToSrpms2 < ActiveRecord::Migration
  def self.up
    add_index :srpms, :vendor
    add_index :srpms, :branch
  end

  def self.down
    remove_index :srpms, :vendor
    remove_index :srpms, :branch
  end
end
