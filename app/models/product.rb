class Product < ActiveRecord::Base
  validates_presence_of :item_num, :price
  has_many :order_items
  has_many :orders, :through => :order_items
  
  validates_uniqueness_of :item_num
  validates_uniqueness_of :upc, :allow_blank => true
  validates_presence_of :min_qty, :if => Proc.new {|obj| TRADESHOW}
  validates_numericality_of :min_qty, :if => Proc.new {|obj| TRADESHOW}
  
  scope :active, :conditions => ['deleted = ?', false]
  
  def id_with_start_date
    st = start_date_or_today.beginning_of_month.strftime("%Y-%m-%d")
    "#{self.id}-#{st}"
  end

  def start_date_or_today
    if start_date.blank? || start_date < Time.now.to_date
      Time.now.to_date
    else
      start_date
    end.beginning_of_month
  end
  
  
  def destroy
    update_attribute :deleted, true
  end
end
