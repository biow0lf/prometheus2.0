class CleanLeadersModel < ActiveRecord::Migration
  def self.up
    remove_column :leaders, :branch
    remove_column :leaders, :vendor
  end

  def self.down
    add_column :leaders, :branch, :string
    add_column :leaders, :vendor, :string
  end
end