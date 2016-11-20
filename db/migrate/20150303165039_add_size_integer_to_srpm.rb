class AddSizeIntegerToSrpm < ActiveRecord::Migration[4.2]
  def change
    add_column :srpms, :size_integer, :integer
  end
end
