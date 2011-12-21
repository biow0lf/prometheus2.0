# encoding: utf-8

class AddMaintainerProfile < ActiveRecord::Migration
  def change
    add_column :maintainers, :time_zone, :string, :default => "UTC"
    add_column :maintainers, :jabber, :string, :default => ""
    add_column :maintainers, :info, :text, :default => ""
  end
end
