class Company < ActiveRecord::Base
  belongs_to :owner, class_name: "User", foreign_key: :owner_id
  has_many :vacancies
  has_many :resumes
  validates :short_name, :official_name, :legal_address, :phone_1, :description, :presence => true
  
  validates_format_of :email_1, :email_2, :with => /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i, allow_blank: true
  validates_format_of :inn, with: /^\d{10}$/i
  validates_format_of :ogrn, with: /^\d{13}$/i, allow_blank: true
  validates :kpp, :presence => true
  validates_format_of :kpp, with: /^\d{9}$/i, allow_blank: true
  
  before_save :sanitize_contacts
  scope :authenticated, { joins: :owner, :conditions=> {users: { status: [1, 2, 3] } }, :order => 'short_name'}
  
  def sanitize_contacts
    self.website = self.website.gsub(/(http:\/\/|https:\/\/)/, "")
    #self.phone_1 = self.phone_1.gsub(/(\+|\-|\(|\))/, "").gsub(" ", "")
    #self.phone_2 = self.phone_2.gsub(/(\+|\-|\(|\))/, "").gsub(" ", "")
  end
end
