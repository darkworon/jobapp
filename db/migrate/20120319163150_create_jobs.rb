class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title
      t.text :description
      t.text :career
      t.integer :entry_type
      t.string :city
      t.string :name
      t.string :phone
      t.string :email
      t.integer :salary
      t.date :birthdate
      t.integer :experience_period

      t.timestamps
    end
  end
end
