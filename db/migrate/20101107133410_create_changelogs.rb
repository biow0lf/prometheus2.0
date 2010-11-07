class CreateChangelogs < ActiveRecord::Migration
  def self.up
    create_table :changelogs do |t|
      t.integer :srpm_id
      t.string :changelogtime
      t.binary :changelogname
      t.binary :changelogtext

      t.timestamps
    end

    add_index :changelogs, :srpm_id
  end

  def self.down
    drop_table :changelogs
  end
end
