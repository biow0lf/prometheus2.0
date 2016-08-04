class AddEpochToObsoletes < ActiveRecord::Migration[5.0]
  def change
    add_column :obsoletes, :epoch, :integer
  end
end
