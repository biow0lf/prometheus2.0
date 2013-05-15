class AddIndexesTopackages < ActiveRecord::Migration
  def change
    add_index :packages, :branch
    add_index :packages, :vendor
    add_index :packages, :sourcepackage
    add_index :packages, :arch
  end
end
