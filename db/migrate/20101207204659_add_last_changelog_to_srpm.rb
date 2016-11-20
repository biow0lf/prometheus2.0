class AddLastChangelogToSrpm < ActiveRecord::Migration[4.2]
  def change
    add_column :srpms, :changelogtime, :string
    add_column :srpms, :changelogname, :string
    add_column :srpms, :changelogtext, :text
  end
end
