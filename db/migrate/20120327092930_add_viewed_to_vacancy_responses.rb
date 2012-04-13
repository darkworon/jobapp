class AddViewedToVacancyResponses < ActiveRecord::Migration
  def change
    add_column :vacancy_responses, :viewed_by_recipient, :boolean, default: 0
    add_column :vacancy_responses, :viewed_by_sender, :boolean, default: 1
  end
end
