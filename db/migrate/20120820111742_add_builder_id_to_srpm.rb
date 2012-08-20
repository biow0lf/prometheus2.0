class AddBuilderIdToSrpm < ActiveRecord::Migration
  def change
    add_column :srpms, :builder_id, :integer
  end
end
