class AddBuilderIdToSrpm < ActiveRecord::Migration[4.2]
  def change
    add_column :srpms, :builder_id, :integer
  end
end
