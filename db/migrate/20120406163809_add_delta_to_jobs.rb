class AddDeltaToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :delta, :boolean, :default => true, :null => false
  end
end
