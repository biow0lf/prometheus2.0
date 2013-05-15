class AddSpecIdToSrpm < ActiveRecord::Migration
  def change
    add_column :srpms, :specfile_id, :integer, :default => nil
  end
end
