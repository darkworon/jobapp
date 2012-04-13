#encoding: utf-8
class Vacancy < Job
  belongs_to :user
  has_many :vacancy_responses
  belongs_to :company
  validates :title, :type_of_job, :education, :sex, :company, :description, :career, :city, :name, :phone, :experience_period, presence: true
  validates_numericality_of :salary
  #before_save :set_entry_type
  #scope :all, where(:entry_type => 1)
  
  #def self.where(params)
  #  Job.where(entry_type: 1, params)
  #end
  #def translated_type_of_job
  #    I18n.t(type_of_job, :scope => :types_of_job)
  #end

  
  def translated_education
      I18n.t(education, :scope => :educations)
  end
  def translated_sex
      I18n.t(sex, :scope => '.vacancy.sexes')
  end
  def translated_experience_of_work
      I18n.t(experience_period, :scope => '.vacancy.experience_periods')
  end
  
  
  #def set_entry_type
  #  self.entry_type = 1
  #end

end
