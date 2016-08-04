class AddEpochToProvides < ActiveRecord::Migration[5.0]
  def change
    add_column :provides, :epoch, :integer
  end
end
