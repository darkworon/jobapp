class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :pricelist_id
      t.decimal :sum, :precision => 8, :scale => 2, :default => 0.0
      t.integer :payment_provider_id
      t.integer :transaction_id
      t.datetime :transaction_date
      t.datetime :due_date
      t.datetime :date_start
      t.integer :quantity_remained
      t.integer :status, default: 0
      
      t.timestamps
    end
  end
  
  def up
    change_column :orders, :id, :integer, :limit => 8
    change_column :users, :id, :integer, :limit => 8
    change_column :jobs, :id, :integer, :limit => 8
  end
end
