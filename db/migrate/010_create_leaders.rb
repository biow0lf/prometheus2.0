class CreateLeaders < ActiveRecord::Migration
  def self.up
    create_table :leaders do |t|
      t.string :package
      t.string :login
      #t.string :branch
      t.integer :branch_id

      t.timestamps
    end
  end

  def self.down
    drop_table :leaders
  end
end
