# *- encoding: utf-8
class User < ActiveRecord::Base
  #has_secure_password
  has_many :vacancies
  has_many :resumes
  has_many :activations
  has_many :favorites
  has_many :password_recovers
  has_many :jobs
  has_many :companies, :class_name => 'Company', :foreign_key => 'owner_id'
  has_many :orders
  has_many :subscriptions, :class_name => 'Order', :foreign_key => 'user_id', conditions: ['status = 1']
  # Vacancy Response
  has_many :sent_vacancy_responses, :class_name => 'VacancyResponse', :foreign_key => 'sender_id'
  has_many :recieved_vacancy_responses, :class_name => 'VacancyResponse', :foreign_key => 'recipient_id'
  has_many :unreaded_recieved_vacancy_responses, :class_name => 'VacancyResponse', :foreign_key => 'recipient_id', conditions: ['viewed_by_recipient = 0']
  has_many :unreaded_sent_vacancy_responses, :class_name => 'VacancyResponse', :foreign_key => 'sender_id', conditions: ['viewed_by_sender = 0']
  
  # Resume Response
  has_many :sent_resume_responses, :class_name => 'ResumeResponse', :foreign_key => 'sender_id'
  has_many :recieved_resume_responses, :class_name => 'ResumeResponse', :foreign_key => 'recipient_id'
  has_many :unreaded_recieved_resume_responses, :class_name => 'ResumeResponse', :foreign_key => 'recipient_id', conditions: ['viewed_by_recipient = 0']
  has_many :unreaded_sent_resume_responses, :class_name => 'ResumeResponse', :foreign_key => 'sender_id', conditions: ['viewed_by_sender = 0']
  
  
  ##has_many :sended_responses, class_name: "VacancyResponse", conditions: ['sender_id = ?', self.id]
  #has_many :recieved_vacancy_responses, foreign_key: :sender_id
  #has_many :jobs
  attr_accessor :password, :password_confirmation
  attr_accessible :email, :password, :password_confirmation, :firstname, :lastname, :password_digest, :city, :phone, :status, :time_zone, :birthdate
  validates_uniqueness_of :email, allow_blank: true
  validates_presence_of :email
  validates_format_of :email, with: /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i, allow_blank: true
  validates_presence_of :password, on: :create
  validates_length_of :password, minimum: 4, allow_blank: true
  validates_presence_of :password_confirmation, on: :create
  validates_confirmation_of :password
  #validates :email, :password, :password_confirmation, :firstname, :lastname, :city, :phone, :presence => true
  
  #validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+.)+[a-z]{2,})$/i, :on => :creation
  
  def authenticate(unencrypted_password)
    if BCrypt::Password.new(password_digest) == unencrypted_password
      self
    else
      false
    end
  end
  
  def recover_authenticate
    unless password_recovers.first.nil?
      self
    else
      false
    end
  end

  def password=(unencrypted_password)
      @password = unencrypted_password
      unless unencrypted_password.blank?
        self.password_digest = BCrypt::Password.create(unencrypted_password)
      end
  end
  
  def name
    name = email
    unless firstname.blank?
      name = firstname
    end
    name
  end

  def full_name
    name = email
    unless firstname.blank?
      name = firstname
    end
    unless lastname.blank?
      name = lastname
    end
    unless firstname.blank? and lastname.blank?
      name = "#{firstname} #{lastname}"
    end
    
    name
  end
  
  def translated_status
    I18n.t(status, :scope => '.user.statuses')
  end
  
  
  def is_banned?
    return true if status == -1
    false
  end
  
  def is_activated?
    return false if status == 0
    true
  end
  
  def is_moderator?
    return true if status >= 2
    false
  end
  
  def is_admin?
    return true if status == 3
    false
  end
  
  def job_already_favorited?(job)
    return false if self.favorites.find_by_job_id(job).nil?
    true
  end
  
  def can_edit?(job)
    if job.user == self or self.is_moderator?
      true
    else
      false
    end
  end
  

  def can_add_to_favorites?(job)
    return false if job.user == self
    true
  end
  
  def self.hide_unpaid_jobs
    users = self.where(status: 1)
    users.each do |u|
      @vacancies_max = u.orders.sum(:quantity_remained, joins: :pricelist, conditions: {status: 1, pricelists: {entry_type: 3}}) + 7
      @resumes_max = u.orders.sum(:quantity_remained, joins: :pricelist, conditions: {status: 1, pricelists: {entry_type: 4}}) + 3
      
      user_vacancies = u.vacancies.where(status: 1).order(["priority", "created_at"])
      user_resumes = u.resumes.where(status: 1).order(["priority", "created_at"])
      diff = user_vacancies.count - @vacancies_max
      while diff > 0
        vacancy = user_vacancies[diff - 1]
        vacancy.status = 0
        vacancy.save
        diff -= 1
      end
      diff = user_resumes.count - @resumes_max
      while diff > 0
        resume = user_resumes[diff - 1]
        resume.status = 0
        resume.save
        diff -= 1
      end
    end
  end
  
  def active_vacancies
    self.vacancies.where(status: 1)
  end
  
  def inactive_vacancies
    self.vacancies.where(status: 0)
  end
  
  def active_resumes
    self.resumes.where(status: 1)
  end
  
  def inactive_resumes
    self.resumes.where(status: 0)
  end
  
end
