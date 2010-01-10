class AddIndexesToSrpms < ActiveRecord::Migration
  def self.up
    add_index :srpms, :name
  end

  def self.down
    remove_index :srpms, :name
  end
end
