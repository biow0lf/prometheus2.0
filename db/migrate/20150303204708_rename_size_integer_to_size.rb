class RenameSizeIntegerToSize < ActiveRecord::Migration[4.2]
  def change
    rename_column :srpms, :size_integer, :size
  end
end
