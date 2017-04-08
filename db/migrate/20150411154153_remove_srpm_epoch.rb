class RemoveSrpmEpoch < ActiveRecord::Migration[4.2]
  def change
    remove_column :srpms, :epoch, :string
  end
end
