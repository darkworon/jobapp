class AddStatusToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
        t.integer :status, default: 0
    end
  end
end
