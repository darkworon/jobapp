class CreateVacancyResponses < ActiveRecord::Migration
  def change
    create_table :vacancy_responses do |t|
      t.integer :vacancy_id
      t.integer :resume_id
      t.integer :sender_id
      t.integer :recipient_id
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
