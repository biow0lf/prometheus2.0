# encoding: utf-8

class CreateBranches < ActiveRecord::Migration
  def change
    create_table :branches do |t|
      t.string :vendor
      t.string :name
      t.string :url
      t.string :srpms_path
      t.string :binary_x86_path
      t.string :noarch_path
      t.string :binary_x86_64_path
      t.string :acls_url
      t.string :leaders_url
      t.string :acls_groups_url

      t.timestamps
    end
  end
end
