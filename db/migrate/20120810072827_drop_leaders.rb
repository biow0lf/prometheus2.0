class DropLeaders < ActiveRecord::Migration[4.2]
  def change
    drop_table :leaders
  end
end
