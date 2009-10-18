class CreateBranches < ActiveRecord::Migration
  def self.up
    create_table :branches do |t|
      t.string :fullname
      t.string :urlname
      t.string :srpms_path
      t.string :binary_x86_path
      t.string :noarch_path
      t.string :binary_x86_64_path
      t.string :acls_url
      t.string :leaders_url
      t.string :acls_groups_url
      t.boolean :altlinux

      t.timestamps
    end
  end

  def self.down
    drop_table :branches
  end
end
