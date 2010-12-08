class AddSpecIdToSrpm < ActiveRecord::Migration
  def self.up
    add_column :srpms, :specfile_id, :integer, :default => nil
  end

  def self.down
    remove_column :srpms, :specfile_id
  end
end
