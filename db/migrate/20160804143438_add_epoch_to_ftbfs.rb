class AddEpochToFtbfs < ActiveRecord::Migration[5.0]
  def change
    add_column :ftbfs, :epoch, :integer
  end
end
