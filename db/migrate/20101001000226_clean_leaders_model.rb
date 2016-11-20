class CleanLeadersModel < ActiveRecord::Migration[4.2]
  def change
    remove_column :leaders, :branch
    remove_column :leaders, :vendor
  end
end
