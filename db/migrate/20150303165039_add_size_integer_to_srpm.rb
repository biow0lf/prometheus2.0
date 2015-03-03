class AddSizeIntegerToSrpm < ActiveRecord::Migration
  def change
    add_column :srpms, :size_integer, :integer
  end
end
