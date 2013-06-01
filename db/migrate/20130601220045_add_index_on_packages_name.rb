class AddIndexOnPackagesName < ActiveRecord::Migration
  def change
    add_index :packages, :name
  end
end
