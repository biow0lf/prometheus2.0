# encoding: utf-8

class AddIndexesToSrpms < ActiveRecord::Migration
  def change
    add_index :srpms, :name
  end
end
