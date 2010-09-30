class AddSrpmIdToPackages < ActiveRecord::Migration
  def self.up
    add_column :packages, :srpm_id, :integer
  end

  def self.down
    remove_columnt :packages, :srpm_id
  end
end