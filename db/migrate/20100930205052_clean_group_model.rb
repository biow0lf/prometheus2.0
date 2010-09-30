class CleanGroupModel < ActiveRecord::Migration
  def self.up
    remove_column :groups, :branch
    remove_column :groups, :vendor
  end

  def self.down
    add_column :groups, :branch, :string
    add_column :groups, :vendor, :string
  end
end