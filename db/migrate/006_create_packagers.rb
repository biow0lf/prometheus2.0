class CreatePackagers < ActiveRecord::Migration
  def self.up
    create_table :packagers do |t|
      t.string :name
      t.string :email
      t.string :login
      t.boolean :team, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :packagers
  end
end
