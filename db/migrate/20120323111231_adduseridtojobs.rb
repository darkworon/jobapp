class Adduseridtojobs < ActiveRecord::Migration
  def change
    change_table :jobs do |t|
        t.references :user
    end
    remove_column :jobs, :author_id
    
  end
end
