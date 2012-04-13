class AddPriorityToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :priority, :integer, default: 1
  end
end
