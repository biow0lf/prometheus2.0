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
      t.integer :branch_id
      t.binary :rawspec

      t.boolean :fresh, :default => false

      t.timestamps
    end

    add_index :srpms, :name
    add_index :srpms, :group_id
    add_index :srpms, :packager_id
    add_index :srpms, :branch_id
    add_index :srpms, :fresh
  end

  def self.down
    drop_table :srpms
  end
end
