class AddIndexesToRepocops < ActiveRecord::Migration[4.2]
  def change
    add_index :repocops, :srcname
    add_index :repocops, :srcversion
    add_index :repocops, :srcrel
  end
end
