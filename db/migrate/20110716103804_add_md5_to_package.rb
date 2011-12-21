# encoding: utf-8

class AddMd5ToPackage < ActiveRecord::Migration
  def change
    add_column :packages, :md5, :string
  end
end
