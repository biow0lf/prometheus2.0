# encoding: utf-8

class AddMd5ToSrpms < ActiveRecord::Migration
  def change
    add_column :srpms, :md5, :string
  end
end
