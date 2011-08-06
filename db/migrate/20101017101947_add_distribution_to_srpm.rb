class AddDistributionToSrpm < ActiveRecord::Migration
  def up
    add_column :srpms, :distribution, :string
  end

  def down
    remove_column :srpms, :distribution
  end
end