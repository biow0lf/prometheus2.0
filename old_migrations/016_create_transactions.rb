class CreateTransactions < ActiveRecord::Migration
  def self.up
    create_table :transactions do |t|
      t.integer :trans_id
      t.string :login
      t.string :status
      t.string :branch

      t.timestamps
    end
  end

  def self.down
    drop_table :transactions
  end
end
