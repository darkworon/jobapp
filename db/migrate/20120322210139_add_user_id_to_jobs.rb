class AddUserIdToJobs < ActiveRecord::Migration
  def change
    change_table :jobs do |t|
        t.references :user
    end
  end

end
