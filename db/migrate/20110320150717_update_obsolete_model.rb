class UpdateObsoleteModel < ActiveRecord::Migration
  def self.up
    remove_column :obsoletes, :type
    add_column :obsoletes, :epoch, :string
    add_column :obsoletes, :flags, :integer
  end

  def self.down
    add_column :obsoletes, :type, :string
    remove_column :obsoletes, :epoch
    remove_column :obsoletes, :flags
  end
end
