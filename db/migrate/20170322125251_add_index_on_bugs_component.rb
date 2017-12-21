# frozen_string_literal: true

class AddIndexOnBugsComponent < ActiveRecord::Migration[5.0]
  def change
    add_index :bugs, :component
  end
end
