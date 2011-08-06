class AddArchToFtbfs < ActiveRecord::Migration
  def up
    add_column :ftbfs, :arch, :string
  end

  def down
    remove_column :ftbfs, :arch
  end
end
