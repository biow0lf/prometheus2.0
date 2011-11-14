# encoding: utf-8

class AddIndexesToSrpms2 < ActiveRecord::Migration
  def up
    add_index :srpms, :vendor
    add_index :srpms, :branch
  end

  def down
    remove_index :srpms, :vendor
    remove_index :srpms, :branch
  end
end
