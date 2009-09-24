class CreateFtbfs < ActiveRecord::Migration
  def self.up
    create_table :ftbfs do |t|
      t.string :name
      t.string :version
      t.string :release
      t.integer :weeks
      t.string :login

      t.timestamps
    end
  end

  def self.down
    drop_table :ftbfs
  end
end
