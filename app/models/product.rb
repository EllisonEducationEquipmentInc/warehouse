class Product < ActiveRecord::Base
  validates_presence_of :item_num, :price
  has_many :order_items
  has_many :orders, :through => :order_items
  
  validates_uniqueness_of :item_num
  validates_uniqueness_of :upc, :allow_blank => true
  validates_presence_of :min_qty, :if => Proc.new {|obj| TRADESHOW}
  validates_numericality_of :min_qty, :if => Proc.new {|obj| TRADESHOW}

  validates_presence_of :coupon_price_1, :if => Proc.new {|obj| obj.coupon_1.present?}
  validates_presence_of :coupon_price_2, :if => Proc.new {|obj| obj.coupon_2.present?}
  validates_presence_of :coupon_price_3, :if => Proc.new {|obj| obj.coupon_3.present?}
  validates_presence_of :coupon_price_4, :if => Proc.new {|obj| obj.coupon_4.present?}
  validates_presence_of :coupon_price_5, :if => Proc.new {|obj| obj.coupon_5.present?}
  
  scope :active, -> { where(deleted: false) }
  
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

  def price(coupon = nil)
    if coupon.present? && [self.coupon_1, self.coupon_2, self.coupon_3, self.coupon_4, self.coupon_5].include?(coupon)
      case coupon
      when self.coupon_1
        read_attribute(:coupon_price_1)
      when self.coupon_2
        read_attribute(:coupon_price_2)
      when self.coupon_3
        read_attribute(:coupon_price_3)
      when self.coupon_4
        read_attribute(:coupon_price_4)
      when self.coupon_5
        read_attribute(:coupon_price_5)
      end
    else
      read_attribute :price
    end
  end

  def designer_name
    designer.present? ? designer : "none"
  end
end
