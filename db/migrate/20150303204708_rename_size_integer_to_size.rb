class RenameSizeIntegerToSize < ActiveRecord::Migration
  def change
    rename_column :srpms, :size_integer, :size
  end
end
