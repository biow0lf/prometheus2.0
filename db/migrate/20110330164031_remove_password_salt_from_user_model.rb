# encoding: utf-8

class RemovePasswordSaltFromUserModel < ActiveRecord::Migration
  def change
    remove_column :users, :password_salt
  end
end
