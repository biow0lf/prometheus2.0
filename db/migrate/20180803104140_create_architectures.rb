# frozen_string_literal: true

class CreateArchitectures < ActiveRecord::Migration[5.1]
  def change
    create_table :architectures do |t|
      t.references :platform, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
