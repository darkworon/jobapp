class AddAuthorIdToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :author_id, :integer
    remove_column :jobs, :user_id
  end
end
