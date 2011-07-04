class CreateFileCaches < ActiveRecord::Migration
  def self.up
    create_table :file_caches do |t|
      t.string :name
      t.binary :file

      t.timestamps
    end
  end

  def self.down
    drop_table :file_caches
  end
end
