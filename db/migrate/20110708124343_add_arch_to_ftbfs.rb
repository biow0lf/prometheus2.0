class AddArchToFtbfs < ActiveRecord::Migration[4.2]
  def change
    add_column :ftbfs, :arch, :string
  end
end
