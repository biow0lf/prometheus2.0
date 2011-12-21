# encoding: utf-8

class AddIndexesToSrpms2 < ActiveRecord::Migration
  def change
    add_index :srpms, :vendor
    add_index :srpms, :branch
  end
end
