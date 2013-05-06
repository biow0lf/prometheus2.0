class RemoveTypeFromRequires < ActiveRecord::Migration
  def change
    remove_column :requires, :type
  end
end
