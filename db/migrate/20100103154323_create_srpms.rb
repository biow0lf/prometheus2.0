class CreateSrpms < ActiveRecord::Migration
  def self.up
    create_table :srpms do |t|
      t.string :branch
      t.string :vendor
      t.string :filename
      t.string :name
      t.string :version
      t.string :release
      t.string :epoch
      t.string :summary
      t.string :license
      t.string :url
      t.text :description
      t.datetime :buildtime
      t.string :size

      t.timestamps
    end
  end

  def self.down
    drop_table :srpms
  end
end
