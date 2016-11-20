class AddIndexesTopackages < ActiveRecord::Migration[4.2]
  def change
    add_index :packages, :branch
    add_index :packages, :vendor
    add_index :packages, :sourcepackage
    add_index :packages, :arch
  end
end
