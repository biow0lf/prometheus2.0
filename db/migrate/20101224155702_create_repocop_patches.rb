# encoding: utf-8

class CreateRepocopPatches < ActiveRecord::Migration
  def change
    create_table :repocop_patches do |t|
      t.string :name
      t.string :version
      t.string :release
      t.string :url

      t.timestamps
    end

    add_index :repocop_patches, :name
  end
end
