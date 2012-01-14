class AddDeltaToSrpms < ActiveRecord::Migration
  def change
    add_column :srpms, :delta, :boolean, :default => true, :null => false
  end
end
