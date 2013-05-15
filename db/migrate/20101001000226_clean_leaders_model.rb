class CleanLeadersModel < ActiveRecord::Migration
  def change
    remove_column :leaders, :branch
    remove_column :leaders, :vendor
  end
end
