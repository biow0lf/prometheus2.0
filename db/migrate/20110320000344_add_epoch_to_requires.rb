class AddEpochToRequires < ActiveRecord::Migration[4.2]
  def change
    add_column :requires, :epoch, :string
  end
end
