class CreateRequires < ActiveRecord::Migration
  def self.up
    create_table :requires do |t|
      t.integer :package_id
      t.string :name
      t.string :type
      t.string :version
      t.string :release

      t.timestamps
    end
  end

  def self.down
    drop_table :requires
  end
end
