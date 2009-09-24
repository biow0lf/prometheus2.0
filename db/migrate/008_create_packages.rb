class CreatePackages < ActiveRecord::Migration
  def self.up
    create_table :packages do |t|
      t.string :filename
      t.string :sourcepackage
      t.string :name
      t.string :version
      t.string :release
      t.string :group
#      t.integer :group_id
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
      t.string :branch

      t.timestamps
    end
  end

  def self.down
    drop_table :packages
  end
end
