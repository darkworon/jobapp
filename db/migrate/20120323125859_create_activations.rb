class CreateActivations < ActiveRecord::Migration
  def change
    create_table :activations do |t|
      t.string :link
      t.integer :user_id

      t.timestamps
    end
  end
end
