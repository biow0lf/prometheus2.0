class UpdateObsoleteModel < ActiveRecord::Migration
  def change
    remove_column :obsoletes, :type
    add_column :obsoletes, :epoch, :string
    add_column :obsoletes, :flags, :integer
  end
end
