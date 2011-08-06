class CreatePatches < ActiveRecord::Migration
  def up
    create_table :patches do |t|
      t.integer :branch_id
      t.integer :srpm_id
      t.binary :patch

      t.timestamps
    end

    add_index :patches, :branch_id
    add_index :patches, :srpm_id
  end

  def down
    drop_table :patches
  end
end
