class AddFieldToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :type_of_job, :integer
    add_column :jobs, :education, :integer
    add_column :jobs, :sex, :integer
    add_column :jobs, :min_age, :integer, default: 22
    add_column :jobs, :max_age, :integer, default: 50
  end
end
