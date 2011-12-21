# encoding: utf-8

class AddEpochToRequires < ActiveRecord::Migration
  def change
    add_column :requires, :epoch, :string
  end
end
