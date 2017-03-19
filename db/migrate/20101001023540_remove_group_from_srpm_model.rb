class RemoveGroupFromSrpmModel < ActiveRecord::Migration[4.2]
  def change
    remove_column :srpms, :group, :string
  end
end
