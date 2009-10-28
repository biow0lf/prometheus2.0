class CreateGroups < ActiveRecord::Migration
  def self.up
    create_table :groups do |t|
      t.string :name
      t.integer :branch_id

      t.timestamps
    end

    add_index :groups, :branch_id
  end

  def self.down
    drop_table :groups
  end
end
