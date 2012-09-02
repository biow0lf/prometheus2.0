class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.integer :branch_id
      t.integer :srpm_id
      t.binary :source
      t.string :filename
      t.integer :size

      t.timestamps
    end

    add_index :sources, :branch_id
    add_index :sources, :srpm_id
  end
end
