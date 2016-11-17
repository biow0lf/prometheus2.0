class AddAclsUrlToBranch < ActiveRecord::Migration[5.0]
  def change
    add_column :branches, :acls_url, :string
  end
end
