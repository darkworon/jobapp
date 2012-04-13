class RemoveCreationDateFromCompanies < ActiveRecord::Migration
  def up
    remove_column :companies, :creation_date
      end

  def down
    add_column :companies, :creation_date, :datetime
  end
end
