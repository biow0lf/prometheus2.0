class AddSrpmIdToPackages < ActiveRecord::Migration
  def change
    add_column :packages, :srpm_id, :integer
  end
end
