class AddListDateToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :list_date, :datetime, :null => false #, :default => Time.now
  end
end
