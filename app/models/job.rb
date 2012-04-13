#encoding: utf-8
class Job < ActiveRecord::Base
    #attr_accessor :old_id
    before_create :autoset_fields
    has_many :favorites
    belongs_to :user
    VACANCIES_FREE = 7
    RESUMES_FREE = 3
    #belongs_to :job_type
    #validates_presence_of :job_type, presence: true
    #TYPES = {"Vacancy" => 0, "Resume" => 1}
    #validates_presence_of :entry_type, message: :must_be_selected
    #validates :title, :description, :career, :city, :name, :phone, :email, :salary, :presence => true
    
    #validates_presence_of :job_type_id, message: "must be selected"
    
    #def translated_job_entry_type
    #    I18n.t(entry_type, :scope => :job_entry_types)
    #end
    define_index do
        indexes city, sortable: true
        indexes title, sortable: true
        #indexes career
        #indexes description
        #indexes city
        has created_at
        has list_date
        has status
        has user.status, as: :user_status
        set_property :delta => true
    end
    #is_indexed :fields => ['title', 'city']
    scope :authenticated, { joins: :user, :conditions=> {status: 1, users: { status: [1, 2, 3] } }, :order => 'created_at DESC'}
    scope :authenticated_prof, { joins: :user, :conditions=> {status: 1, users: { status: [1, 2, 3] } }}
    def clear_private_fields
      #self.id = nil
      self.phone = nil
      self.email = nil
      self.name = nil
      #self.city = nil
      #self.salary = nil
      self.birthdate = nil
      self
    end
    
    def autoset_fields
      self.uin = UUIDTools::UUID.timestamp_create.to_s
      #self.list_date = Time.now if self.list_date.blank?
      self.list_date = DateTime.now if self.list_date.blank?
    end
    
    
    #def self.search(arguments)
    #  return [] if arguments.blank?
    #  cond_text, cond_values = [], []
    #  arguments.each do |str|
    #    next if str.blank?  
    #    cond_text << "( %s )" % str.split.map{|w| "title LIKE ? "}.join(" OR ")
    #    cond_values.concat(str.split.map{|w| "%#{w}%"})
    #  end
    #  all :conditions =>  [cond_text.join(" AND "), *cond_values]  ## OR и AND
    #end
    

end
