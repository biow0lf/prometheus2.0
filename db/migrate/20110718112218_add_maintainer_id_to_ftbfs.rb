# encoding: utf-8

class AddMaintainerIdToFtbfs < ActiveRecord::Migration
  def change
    add_column :ftbfs, :maintainer_id, :integer
  end
end
