class CleanTeamModel < ActiveRecord::Migration
  def self.up
    remove_column :teams, :branch
    remove_column :teams, :vendor
  end

  def self.down
    add_column :teams, :branch, :string
    add_column :teams, :vendor, :string
  end
end