class AddArchToFtbfs < ActiveRecord::Migration
  def change
    add_column :ftbfs, :arch, :string
  end
end
