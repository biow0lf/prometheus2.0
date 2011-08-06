class AddEpochToRequires < ActiveRecord::Migration
  def up
    add_column :requires, :epoch, :string
  end

  def down
    remove_column :requires, :epoch
  end
end
