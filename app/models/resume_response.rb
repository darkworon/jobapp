# encoding: utf-8
class ResumeResponse < ActiveRecord::Base
  belongs_to :sender, class_name: "User", foreign_key: :sender_id
  belongs_to :recipient, class_name: "User", foreign_key: :recipient_id
  belongs_to :vacancy
  belongs_to :resume
  validates_presence_of :vacancy
  
  def translated_status
      I18n.t(status, :scope => '.response.statuses')
  end
  
  
  
end
