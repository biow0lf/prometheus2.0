class AddDistributionToSrpm < ActiveRecord::Migration[4.2]
  def change
    add_column :srpms, :distribution, :string
  end
end
