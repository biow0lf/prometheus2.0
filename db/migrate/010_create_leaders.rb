class CreateLeaders < ActiveRecord::Migration
  def self.up
    create_table :leaders do |t|
      t.string :package
      t.string :login
      t.integer :branch_id

      t.timestamps
    end

    add_index :leaders, :branch_id
  end

  def self.down
    drop_table :leaders
  end
end
