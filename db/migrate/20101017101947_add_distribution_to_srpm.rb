class AddDistributionToSrpm < ActiveRecord::Migration
  def self.up
    add_column :srpms, :distribution, :string
  end

  def self.down
    remove_column :srpms, :distribution
  end
end