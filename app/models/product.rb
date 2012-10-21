class Product < ActiveRecord::Base
  validates_presence_of :item_num, :price
  has_many :order_items
  has_many :orders, :through => :order_items
  
  validates_uniqueness_of :item_num
  validates_uniqueness_of :upc, :allow_blank => true
  validates_presence_of :min_qty, :if => Proc.new {|obj| TRADESHOW}
  validates_numericality_of :min_qty, :if => Proc.new {|obj| TRADESHOW}
  
  scope :active, :conditions => ['deleted = ?', false]
  
  
  def destroy
    update_attribute :deleted, true
  end
end
