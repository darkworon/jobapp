class AddAutoActivateToPricelists < ActiveRecord::Migration
  def change
    add_column :pricelists, :auto_activate, :boolean, default: 0

  end
end
