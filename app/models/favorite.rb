class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :job
  
  
  scope :vacancies, { joins: :job, :conditions => {jobs: { type: "Vacancy" } }, :order => 'id DESC'}
  scope :resumes, { joins: :job, :conditions=> {jobs: { type: "Resume" } }, :order => 'id DESC'}
end
