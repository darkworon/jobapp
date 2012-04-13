class AddDateEndToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :date_end, :datetime

  end
end
