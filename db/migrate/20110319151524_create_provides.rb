class CreateProvides < ActiveRecord::Migration
  def self.up
    create_table :provides do |t|
      t.integer :package_id
      t.string :name
      t.string :type
      t.string :version
      t.string :release

      t.timestamps
    end
  end

  def self.down
    drop_table :provides
  end
end
