class AddMaintainerProfile < ActiveRecord::Migration
  def up
    add_column :maintainers, :time_zone, :string, :default => "UTC"
    add_column :maintainers, :jabber, :string, :default => ""
    add_column :maintainers, :info, :text, :default => ""
  end

  def down
    remove_column :maintainers, :time_zone
    remove_column :maintainers, :jabber
    remove_column :maintainers, :info
  end
end
