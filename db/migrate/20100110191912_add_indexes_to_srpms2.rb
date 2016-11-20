class AddIndexesToSrpms2 < ActiveRecord::Migration[4.2]
  def change
    add_index :srpms, :vendor
    add_index :srpms, :branch
  end
end
