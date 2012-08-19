# encoding: utf-8

class AddUnconfirmedEmailToUsers < ActiveRecord::Migration
  def change
    add_column :users, :unconfirmed_email, :string
  end
end
