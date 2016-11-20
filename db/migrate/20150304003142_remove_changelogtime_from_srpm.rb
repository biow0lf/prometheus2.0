class RemoveChangelogtimeFromSrpm < ActiveRecord::Migration[4.2]
  def change
    remove_column :srpms, :changelogtime
  end
end
