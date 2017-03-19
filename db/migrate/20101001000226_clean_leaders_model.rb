class CleanLeadersModel < ActiveRecord::Migration[4.2]
  def change
    remove_column :leaders, :branch, :string
    remove_column :leaders, :vendor, :string
  end
end
