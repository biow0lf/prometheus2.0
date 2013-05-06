class CleanGroupModel < ActiveRecord::Migration
  def change
    remove_column :groups, :branch
    remove_column :groups, :vendor
  end
end
