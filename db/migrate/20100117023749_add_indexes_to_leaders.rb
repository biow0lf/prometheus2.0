class AddIndexesToLeaders < ActiveRecord::Migration
  def self.up
    add_index :leaders, :branch
    add_index :leaders, :vendor
    add_index :leaders, :package
  end

  def self.down
    remove_index :leaders, :branch
    remove_index :leaders, :vendor
    remove_index :leaders, :package
  end
end
