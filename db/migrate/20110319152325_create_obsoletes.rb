# encoding: utf-8

class CreateObsoletes < ActiveRecord::Migration
  def change
    create_table :obsoletes do |t|
      t.integer :package_id
      t.string :name
      t.string :type
      t.string :version
      t.string :release

      t.timestamps
    end
  end
end
