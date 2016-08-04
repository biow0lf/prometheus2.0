class AddEpochToRequiresNew < ActiveRecord::Migration[5.0]
  def change
    add_column :requires, :epoch, :integer
  end
end
