class AddIndexesToSrpms < ActiveRecord::Migration[4.2]
  def change
    add_index :srpms, :name
  end
end
