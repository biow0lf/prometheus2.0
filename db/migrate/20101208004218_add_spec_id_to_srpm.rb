class AddSpecIdToSrpm < ActiveRecord::Migration
  def up
    add_column :srpms, :specfile_id, :integer, :default => nil
  end

  def down
    remove_column :srpms, :specfile_id
  end
end
