class AddMaintainerProfile < ActiveRecord::Migration
  def self.up
    add_column :maintainers, :time_zone, :string, :default => "UTC"
    add_column :maintainers, :jabber, :string, :default => :null
    add_column :maintainers, :info, :text, :default => :null
  end

  def self.down
    remove_column :maintainers, :time_zone
    remove_column :maintainers, :jabber
    remove_column :maintainers, :info
  end
end
