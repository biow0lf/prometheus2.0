class CreateRepocops < ActiveRecord::Migration
  def self.up
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

  def self.down
    drop_table :repocops
  end
end
