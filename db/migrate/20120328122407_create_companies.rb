class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :short_name, limit: 256
      t.string :official_name, limit: 256
      t.string :address
      t.string :legal_address
      t.string :phone_1, limit: 20
      t.string :phone_2, limit: 20
      t.string :email_1, limit: 128
      t.string :email_2, limit: 128
      t.string :inn, limit: 14
      t.string :kpp, limit: 14
      t.string :ogrn, limit: 30
      t.string :website, limit: 256
      t.text :description
      t.date :creation_date
      t.integer :owner_id, limit: 8
      t.timestamps
    end
  end
end
