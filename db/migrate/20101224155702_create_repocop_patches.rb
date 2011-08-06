class CreateRepocopPatches < ActiveRecord::Migration
  def up
    create_table :repocop_patches do |t|
      t.string :name
      t.string :version
      t.string :release
      t.string :url

      t.timestamps
    end

    add_index :repocop_patches, :name
  end

  def down
    drop_table :repocop_patches
  end
end
