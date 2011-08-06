class CleanSrpmModel < ActiveRecord::Migration
  def up
    remove_column :srpms, :branch
    remove_column :srpms, :vendor
  end

  def down
    add_column :srpms, :branch, :string
    add_column :srpms, :vendor, :string
  end
end