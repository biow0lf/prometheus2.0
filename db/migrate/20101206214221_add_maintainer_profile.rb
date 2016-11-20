class AddMaintainerProfile < ActiveRecord::Migration[4.2]
  def change
    add_column :maintainers, :time_zone, :string, default: 'UTC'
    add_column :maintainers, :jabber, :string, default: ''
    add_column :maintainers, :info, :text, default: ''
  end
end
