class RemoveGroupFromSrpmModel < ActiveRecord::Migration
  def change
    remove_column :srpms, :group
  end
end
