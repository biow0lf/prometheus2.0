class RemoveSpecfileIdFromSrpm < ActiveRecord::Migration[4.2]
  def change
    remove_column :srpms, :specfile_id, :integer, default: nil
  end
end
