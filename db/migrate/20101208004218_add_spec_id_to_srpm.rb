# encoding: utf-8

class AddSpecIdToSrpm < ActiveRecord::Migration
  def change
    add_column :srpms, :specfile_id, :integer, :default => nil
  end
end
