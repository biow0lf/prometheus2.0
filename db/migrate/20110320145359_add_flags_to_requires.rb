class AddFlagsToRequires < ActiveRecord::Migration
  def self.up
    add_column :requires, :flags, :integer
  end

  def self.down
    remove_column :requires, :flags
  end
end
