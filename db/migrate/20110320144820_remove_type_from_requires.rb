class RemoveTypeFromRequires < ActiveRecord::Migration[4.2]
  def change
    remove_column :requires, :type
  end
end
