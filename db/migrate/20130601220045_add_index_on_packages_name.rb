class AddIndexOnPackagesName < ActiveRecord::Migration[4.2]
  def change
    add_index :packages, :name
  end
end
