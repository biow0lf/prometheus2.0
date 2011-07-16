class AddMd5ToSrpms < ActiveRecord::Migration
  def self.up
    add_column :srpms, :md5, :string
  end

  def self.down
    remove_column :srpms, :md5
  end
end
