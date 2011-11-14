# encoding: utf-8

class AddSrpmIdToPackages < ActiveRecord::Migration
  def up
    add_column :packages, :srpm_id, :integer
  end

  def down
    remove_columnt :packages, :srpm_id
  end
end
