class CreateResumeResponses < ActiveRecord::Migration
  def change
    create_table :resume_responses do |t|
      t.integer :resume_id
      t.integer :vacancy_id
      t.integer :sender_id
      t.integer :recipient_id
      t.integer :status, default: 0
      t.boolean :viewed_by_recipient, default: 0
      t.boolean :viewed_by_sender, default: 1
      t.timestamps
    end
  end
end
