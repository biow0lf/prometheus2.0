# frozen_string_literal: true

class AddBuildhostToSrpms < ActiveRecord::Migration[5.1]
  def change
    add_column :srpms, :buildhost, :string
  end
end
