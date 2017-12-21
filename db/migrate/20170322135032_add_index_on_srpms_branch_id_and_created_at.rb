# frozen_string_literal: true

class AddIndexOnSrpmsBranchIdAndCreatedAt < ActiveRecord::Migration[5.0]
  def change
    add_index :srpms, [:branch_id, :created_at]
  end
end
