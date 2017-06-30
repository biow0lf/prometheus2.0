class AddForeignKeySrpmsBranch < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :srpms, :branches
  end
end
