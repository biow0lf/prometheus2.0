class RenameChangelogtimeDatetimeToChangelogtime < ActiveRecord::Migration
  def change
    rename_column :srpms, :changelogtime_datetime, :changelogtime
  end
end
