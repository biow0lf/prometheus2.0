class RemoveLoginFromLeaderModel < ActiveRecord::Migration[4.2]
  def change
    remove_column :leaders, :login
  end
end
