class CleanGroupModel < ActiveRecord::Migration
  def up
    remove_column :groups, :branch
    remove_column :groups, :vendor
  end

  def down
    add_column :groups, :branch, :string
    add_column :groups, :vendor, :string
  end
end