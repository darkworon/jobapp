class AddTimeZoneToUsers < ActiveRecord::Migration
  def change
    add_column :users, :time_zone, :string, default: "Moscow"

  end
end
