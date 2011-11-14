# encoding: utf-8

class CreateRequires < ActiveRecord::Migration
  def up
    create_table :requires do |t|
      t.integer :package_id
      t.string :name
      t.string :type
      t.string :version
      t.string :release

      t.timestamps
    end
  end

  def down
    drop_table :requires
  end
end
