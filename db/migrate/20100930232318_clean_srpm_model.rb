class CleanSrpmModel < ActiveRecord::Migration[4.2]
  def change
    remove_column :srpms, :branch
    remove_column :srpms, :vendor
  end
end
