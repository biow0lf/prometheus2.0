class RemoveLoginFromLeaderModel < ActiveRecord::Migration
  def self.up
    remove_column :leaders, :login
  end

  def self.down
    add_column :leaders, :login, :string
  end
end