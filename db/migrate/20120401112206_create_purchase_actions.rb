class CreatePurchaseActions < ActiveRecord::Migration
  def change
    create_table :purchase_actions do |t|
      t.integer :order_id, limit: 8
      t.datetime :shedule_date
      t.string :entry_uin
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
