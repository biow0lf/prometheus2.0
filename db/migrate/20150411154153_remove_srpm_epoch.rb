class RemoveSrpmEpoch < ActiveRecord::Migration[4.2]
  def change
    remove_column :srpms, :epoch
  end
end
