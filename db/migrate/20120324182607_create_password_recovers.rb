class CreatePasswordRecovers < ActiveRecord::Migration
  def change
    create_table :password_recovers do |t|
      t.string :link
      t.integer :user_id
      t.timestamps
    end
  end
end
