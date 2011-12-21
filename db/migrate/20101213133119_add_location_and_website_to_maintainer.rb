# encoding: utf-8

class AddLocationAndWebsiteToMaintainer < ActiveRecord::Migration
  def change
    add_column :maintainers, :website, :string, :default => ""
    add_column :maintainers, :location, :string, :default => ""
  end
end
