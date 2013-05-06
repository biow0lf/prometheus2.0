class RemoveSpecfileIdFromSrpm < ActiveRecord::Migration
  def change
    remove_column :srpms, :specfile_id
  end
end
