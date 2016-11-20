class AddChangelogtimeDatetimeToSrpm < ActiveRecord::Migration[4.2]
  def change
    add_column :srpms, :changelogtime_datetime, :datetime
  end
end
