class AddArchToFtbfs < ActiveRecord::Migration
  def self.up
    add_column :ftbfs, :arch, :string
  end

  def self.down
    remove_column :ftbfs, :arch
  end
end
