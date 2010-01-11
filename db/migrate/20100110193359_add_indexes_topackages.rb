class AddIndexesTopackages < ActiveRecord::Migration
  def self.up
    add_index :packages, :branch
    add_index :packages, :vendor
    add_index :packages, :sourcepackage
    add_index :packages, :arch
  end

  def self.down
    remove_index :packages, :branch
    remove_index :packages, :vendor
    remove_index :packages, :sourcepackage
    remove_index :packages, :arch
  end
end
