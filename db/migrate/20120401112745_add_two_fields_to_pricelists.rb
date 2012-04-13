class AddTwoFieldsToPricelists < ActiveRecord::Migration
  def change
    add_column :pricelists, :entry_type, :integer
    add_column :pricelists, :quantity, :integer

  end
end
