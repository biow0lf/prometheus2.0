class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.string :filename
      t.string :sourcepackage
      t.string :name
      t.string :version
      t.string :release
      t.string :group
      t.string :epoch
      t.string :arch
      t.string :summary
      t.string :license
      t.string :url
      t.text :description
      t.datetime :buildtime
      t.string :size
      t.string :branch

      t.timestamps
    end
  end
end
