# encoding: utf-8

class AddLocationAndWebsiteToMaintainer < ActiveRecord::Migration
  def up
    add_column :maintainers, :website, :string, :default => ""
    add_column :maintainers, :location, :string, :default => ""
  end

  def down
    remove_column :maintainers, :website
    remove_column :maintainers, :location
  end
end
