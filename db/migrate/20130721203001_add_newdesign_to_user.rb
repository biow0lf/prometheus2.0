class AddNewdesignToUser < ActiveRecord::Migration
  def change
    add_column :users, :newdesign, :boolean, default: false
  end
end
