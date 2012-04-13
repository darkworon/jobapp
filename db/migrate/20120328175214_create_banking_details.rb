class CreateBankingDetails < ActiveRecord::Migration
  def change
    create_table :banking_details do |t|
      t.integer :user_id
      t.integer :company_id
      t.string :bank_name
      t.string :city
      t.string :current_account
      t.string :correspondent_account
      t.string :bik
      t.timestamps
    end
  end
end
