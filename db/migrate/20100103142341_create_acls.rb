class CreateAcls < ActiveRecord::Migration
  def self.up
    create_table :acls do |t|
      t.string :package
      t.string :login
      t.string :branch
      t.string :vendor

      t.timestamps
    end
  end

  def self.down
    drop_table :acls
  end
end
