class AddLocationAndWebsiteToMaintainer < ActiveRecord::Migration[4.2]
  def change
    add_column :maintainers, :website, :string, default: ''
    add_column :maintainers, :location, :string, default: ''
  end
end
