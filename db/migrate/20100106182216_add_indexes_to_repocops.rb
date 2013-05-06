class AddIndexesToRepocops < ActiveRecord::Migration
  def change
    add_index :repocops, :srcname
    add_index :repocops, :srcversion
    add_index :repocops, :srcrel
  end
end
