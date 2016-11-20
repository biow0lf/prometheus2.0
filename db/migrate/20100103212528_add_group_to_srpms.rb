class AddGroupToSrpms < ActiveRecord::Migration[4.2]
  def change
    add_column :srpms, :group, :string
  end
end
