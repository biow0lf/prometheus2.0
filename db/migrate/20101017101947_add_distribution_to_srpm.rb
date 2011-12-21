# encoding: utf-8

class AddDistributionToSrpm < ActiveRecord::Migration
  def change
    add_column :srpms, :distribution, :string
  end
end
