class AddSrpmIdToPackages < ActiveRecord::Migration[4.2]
  def change
    add_column :packages, :srpm_id, :integer
  end
end
