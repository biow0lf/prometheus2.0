class AddLocationAndWebsiteToMaintainer < ActiveRecord::Migration
  def self.up
    add_column :maintainers, :website, :string, :default => ""
    add_column :maintainers, :location, :string, :default => ""
  end

  def self.down
    remove_column :maintainers, :website
    remove_column :maintainers, :location
  end
end
