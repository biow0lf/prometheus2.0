# encoding: utf-8

class CleanSrpmModel < ActiveRecord::Migration
  def change
    remove_column :srpms, :branch
    remove_column :srpms, :vendor
  end
end
