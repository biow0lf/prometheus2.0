class CreateSrpms < ActiveRecord::Migration
  def self.up
    create_table :srpms do |t|
      t.string :filename
      t.string :name
      t.string :version
      t.string :release
      t.string :epoch
      t.integer :group_id
      t.integer :packager_id
      t.string :summary
      t.string :license
      t.string :url
      t.text :description
      t.string :vendor
      t.string :distribution
      t.datetime :buildtime
      t.string :size
      t.string :branch
      t.binary :rawspec

#      t.string :status

      t.timestamps
    end

    add_index :srpms, :name
    add_index :srpms, :group_id
    add_index :srpms, :packager_id
    add_index :srpms, :branch
#    add_index :srpms, :status
  end

  def self.down
    drop_table :srpms
  end
end
