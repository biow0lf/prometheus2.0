class RemoveSrpmEpoch < ActiveRecord::Migration
  def change
    remove_column :srpms, :epoch
  end
end
