class CleanGroupModel < ActiveRecord::Migration[4.2]
  def change
    remove_column :groups, :branch
    remove_column :groups, :vendor
  end
end
