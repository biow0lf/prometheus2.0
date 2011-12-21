# encoding: utf-8

class CreateSpecfiles < ActiveRecord::Migration
  def change
    create_table :specfiles do |t|
      t.integer :srpm_id
      t.integer :branch_id
      t.binary :spec

      t.timestamps
    end

    add_index :specfiles, :srpm_id
    add_index :specfiles, :branch_id
  end
end
