class CreateRepocopPatches < ActiveRecord::Migration
  def self.up
    create_table :repocop_patches do |t|
      t.string :name
      t.string :version
      t.string :release
      t.string :url

      t.timestamps
    end

    add_index :repocop_patches, :name
    add_index :repocop_patches, :version
    add_index :repocop_patches, :release
  end

  def self.down
    drop_table :repocops
  end
end
