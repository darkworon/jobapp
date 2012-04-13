class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :pricelist
  
  
  def translated_status
      I18n.t(status, :scope => '.order.statuses')
  end
  
  def freeze
    self.status = 3
    self.date_end = nil
    self.save
  end
  
  def unfreeze
    self.status = 1
    self.date_end = DateTime.now + self.pricelist.period.days
    self.save
  end
  
  def self.check_subscriptions_time
    orders = self.where(status: 0)
    orders.each do |o|
      if o.due_date <= DateTime.now
        o.status = -1
        o.save
      end
    end
    subscriptions = self.where(status: 1)
    subscriptions.each do |s|
      if s.date_end <= DateTime.now
        s.status = 2
        s.save
      end
      if s.pricelist.price != s.sum
        s.status = 3
        s.save
      end
    end
  end
  
end
