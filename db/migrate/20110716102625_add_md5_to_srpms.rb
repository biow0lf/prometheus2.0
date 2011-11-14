# encoding: utf-8

class AddMd5ToSrpms < ActiveRecord::Migration
  def up
    add_column :srpms, :md5, :string
  end

  def down
    remove_column :srpms, :md5
  end
end
