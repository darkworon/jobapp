class RemovePointsFromPricelists < ActiveRecord::Migration
  def up
    remove_column :pricelists, :points
      end

  def down
    add_column :pricelists, :points, :integer
  end
end
