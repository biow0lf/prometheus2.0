class RemoveTypeFromRequires < ActiveRecord::Migration
  def self.up
    remove_column :requires, :type
  end

  def self.down
    add_column :requires, :type, :string
  end
end
