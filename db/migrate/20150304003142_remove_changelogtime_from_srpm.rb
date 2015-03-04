class RemoveChangelogtimeFromSrpm < ActiveRecord::Migration
  def change
    remove_column :srpms, :changelogtime
  end
end
