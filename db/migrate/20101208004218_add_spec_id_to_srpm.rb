class AddSpecIdToSrpm < ActiveRecord::Migration[4.2]
  def change
    add_column :srpms, :specfile_id, :integer, default: nil
  end
end
