class RemoveSizeFromSrpm < ActiveRecord::Migration
  def change
    remove_column :srpms, :size
  end
end
