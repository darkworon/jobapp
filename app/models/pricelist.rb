class Pricelist < ActiveRecord::Base
  has_many :orders  
  def self.active
    where(status: 1)
  end
  
  def self.set_statuses
    awaiting = self.find(:all, conditions: ['auto_activate = 1 AND status = 0 AND date_start <= ?', Date.today])
    awaiting.each do |p|
      p.status = 1
      p.save
    end
    awaited = self.find(:all, conditions: ['status = 1 AND date_end <= ?', Date.today])
    awaited.each do |p|
      p.status = 2
      p.save
    end
  end
end
