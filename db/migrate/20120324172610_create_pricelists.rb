class CreatePricelists < ActiveRecord::Migration
  def change
    create_table :pricelists do |t|
      t.string :name
      t.decimal :price, precision: 8, scale: 2, default: 0.0
      t.integer :points, default: 0
      t.integer :period, default: 10
      t.boolean :available_for_companies, default: 0
      t.integer :status, default: 0
      t.date :date_start
      t.date :date_end

      t.timestamps
    end
  end
end
