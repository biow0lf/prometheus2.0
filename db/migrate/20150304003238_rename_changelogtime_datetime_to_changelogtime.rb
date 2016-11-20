class RenameChangelogtimeDatetimeToChangelogtime < ActiveRecord::Migration[4.2]
  def change
    rename_column :srpms, :changelogtime_datetime, :changelogtime
  end
end
