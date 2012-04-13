# encoding: utf-8
class Resume < Job
  belongs_to :user
  has_many :vacancy_responses
  validates :title, :type_of_job, :education, :sex, presence: true
  validates :birthdate, date: true
  validates :experience_period, :career, :description, :city, :name, :phone, presence: true
  validates_format_of :email, :with => /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i
  validates_numericality_of :salary
  
  #scope :find_text, :conditions => ['title LIKE ?', "%#{search}%"]
  def translated_education
      I18n.t(education, :scope => :educations)
  end
  def translated_sex
      I18n.t(sex, :scope => '.resume.sexes')
  end
  def translated_experience_of_work
      I18n.t(experience_period, :scope => '.vacancy.experience_periods')
  end
  
  
  #def self.search(search, page)
    #if search
      #find(:all, :conditions => ['lower(title) LIKE ? COLLATE NOCASE', "%#{search}%".downcase]) COLLATE utf8_unicode_ci
    #  find(:all, :conditions => ['title LIKE ?', "%#{search}%"])
     # paginate :per_page => 5, :page => page, :conditions => ['title like ?', "%#{search}%"], :order => '-created_at'
    #else
     # paginate :per_page => 5, :page => page, :order => '-created_at'
    #end
  #end

    
end
