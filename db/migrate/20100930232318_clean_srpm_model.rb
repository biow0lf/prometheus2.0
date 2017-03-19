class CleanSrpmModel < ActiveRecord::Migration[4.2]
  def change
    remove_column :srpms, :branch, :string
    remove_column :srpms, :vendor, :string
  end
end
