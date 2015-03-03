class AddChangelogtimeDatetimeToSrpm < ActiveRecord::Migration
  def change
    add_column :srpms, :changelogtime_datetime, :datetime
  end
end
