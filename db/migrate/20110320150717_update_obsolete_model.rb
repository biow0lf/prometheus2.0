class UpdateObsoleteModel < ActiveRecord::Migration[4.2]
  def change
    remove_column :obsoletes, :type, :string
    add_column :obsoletes, :epoch, :string
    add_column :obsoletes, :flags, :integer
  end
end
