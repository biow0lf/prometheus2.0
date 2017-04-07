class DropAcls < ActiveRecord::Migration[4.2]
  def change
    drop_table :acls do |t|
      t.datetime :created_at
      t.datetime :updated_at
      t.integer :branch_id
      t.integer :maintainer_id
      t.integer :srpm_id
      t.index :branch_id
      t.index :maintainer_id
      t.index :srpm_id
    end
  end
end
