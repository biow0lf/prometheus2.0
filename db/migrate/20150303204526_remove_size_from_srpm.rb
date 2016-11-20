class RemoveSizeFromSrpm < ActiveRecord::Migration[4.2]
  def change
    remove_column :srpms, :size
  end
end
