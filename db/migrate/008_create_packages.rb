class CreatePackages < ActiveRecord::Migration
  def self.up
    create_table :packages do |t|
      t.string :filename
      t.string :sourcepackage
      t.string :name
      t.string :version
      t.string :release
      t.string :group
      t.integer :packager_id
      t.string :epoch
      t.string :arch
      t.string :summary
      t.string :license
      t.string :url
      t.text :description
      t.string :vendor
      t.string :distribution
      t.datetime :buildtime
      t.string :size
      t.integer :branch_id

      t.timestamps
    end

    add_index :packages, :sourcepackage
    add_index :packages, :packager_id
    add_index :packages, :branch_id
  end

  def self.down
    drop_table :packages
  end
end
