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
  end

  def self.down
    drop_table :repocop_patches
  end
end
