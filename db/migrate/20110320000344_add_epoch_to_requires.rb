class AddEpochToRequires < ActiveRecord::Migration
  def self.up
    add_column :requires, :epoch, :string
  end

  def self.down
    remove_column :requires, :epoch
  end
end
