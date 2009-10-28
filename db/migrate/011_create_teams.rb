class CreateTeams < ActiveRecord::Migration
  def self.up
    create_table :teams do |t|
      t.string :name
      t.string :login
      t.integer :branch_id
      t.boolean :leader, :default => false

      t.timestamps
    end

#    add_index :teams, :branch_id
  end

  def self.down
    drop_table :teams
  end
end
