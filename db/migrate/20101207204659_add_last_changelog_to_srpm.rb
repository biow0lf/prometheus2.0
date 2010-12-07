class AddLastChangelogToSrpm < ActiveRecord::Migration
  def self.up
    add_column :srpms, :changelogtime, :string
    add_column :srpms, :changelogname, :string
    add_column :srpms, :changelogtext, :text
  end

  def self.down
    remove_column :srpms, :changelogtime
    remove_column :srpms, :changelogname
    remove_column :srpms, :changelogtext
  end
end
