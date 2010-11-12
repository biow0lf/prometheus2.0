class AddIndexOnChangelogtext < ActiveRecord::Migration
  def self.up
    add_index :changelogs, :changelogtext
  end

  def self.down
    remove_index :changelogs, :changelogtext
  end
end