class MakeStiCompatible < ActiveRecord::Migration
  def change
    remove_column :jobs, :entry_type
    add_column :jobs, :type, :string
  end
end
