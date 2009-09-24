class CreateBranches < ActiveRecord::Migration
  def self.up
    create_table :branches do |t|
      t.string :fullname
      t.string :urlname
      t.string :http_srpms_url
      t.string :ftp_srpms_url
      t.string :http_noarch_url
      t.string :ftp_noarch_url
      t.string :http_i586_url
      t.string :ftp_i586_url
      t.string :http_x86_64_url
      t.string :ftp_x86_64_url
      t.string :acl_packages_url
      t.string :acl_groups_url

      t.timestamps
    end
  end

  def self.down
    drop_table :branches
  end
end
