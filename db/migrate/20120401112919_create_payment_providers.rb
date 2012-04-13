class CreatePaymentProviders < ActiveRecord::Migration
  def change
    create_table :payment_providers do |t|
      t.string :name
      t.string :payment_url
      t.string :website
      t.boolean :is_online_payment, default: 0

      t.timestamps
    end
  end
end
