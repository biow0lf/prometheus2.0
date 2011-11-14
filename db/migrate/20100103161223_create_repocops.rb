# encoding: utf-8

class CreateRepocops < ActiveRecord::Migration
  def up
    create_table :repocops do |t|
      t.string :name
      t.string :version
      t.string :release
      t.string :arch
      t.string :srcname
      t.string :srcversion
      t.string :srcrel
      t.string :testname
      t.string :status
      t.text :message

      t.timestamps
    end
  end

  def down
    drop_table :repocops
  end
end
