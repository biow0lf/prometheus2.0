class DropTableFileCaches < ActiveRecord::Migration
  def self.up
    drop_table :file_caches
  end

  def self.down
    create_table :file_caches do |t|
      t.string :name
      t.binary :file

      t.timestamps
    end
  end
end
