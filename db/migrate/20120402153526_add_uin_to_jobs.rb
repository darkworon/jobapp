class AddUinToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :uin, :string, limit: 36
  end
end
