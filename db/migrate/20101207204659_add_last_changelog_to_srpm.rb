# encoding: utf-8

class AddLastChangelogToSrpm < ActiveRecord::Migration
  def change
    add_column :srpms, :changelogtime, :string
    add_column :srpms, :changelogname, :string
    add_column :srpms, :changelogtext, :text
  end
end
