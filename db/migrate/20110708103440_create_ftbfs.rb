class CreateFtbfs < ActiveRecord::Migration
  def self.up
    create_table :ftbfs do |t|
      t.string :name
      t.string :epoch
      t.string :version
      t.string :release
      t.integer :weeks
      t.integer :branch_id

      t.timestamps
    end
  end

  def self.down
    drop_table :ftbfs
  end
end
