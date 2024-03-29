class Order < ActiveRecord::Base
  attr_accessor :file

  validates_presence_of :sub_total, :total, :sales_tax
  has_many :order_items, :dependent => :destroy, :autosave => true
  has_many :products, :through => :order_items

  validates_presence_of :tax_exempt_number, :if => Proc.new {|o| o.tax_exempt}
  validates_presence_of :customer_number, :employee_number, :if => Proc.new {|o| TRADESHOW}
  validate :validate_order_item

  accepts_nested_attributes_for :order_items, allow_destroy: true

  # TODO: crm
  SALES_TAX = TRADESHOW ? 0.0 : 8.00/100.0

  #after_update :save_order_items
  #validates_associated :order_items

  def order_item_attributes=(order_item_attributes)
    order_item_attributes.each do |attributes|
      if attributes.is_a?(Hash) && attributes[:id].blank?
        order_items.build(attributes)
      elsif attributes.is_a?(Array)
        order_item = order_items.detect { |t| t.id == attributes[0].to_i }
        order_item.attributes = attributes[1]
      else
        order_item = order_items.detect { |t| t.id == attributes[:id].to_i }
        order_item.attributes = attributes
      end
    end
  end

  def save_order_items
    order_items.each do |t|
      if t.should_destroy?
        t.destroy
      else
        t.save(false)
      end
    end
  end

  def by_ship_date
    h={}
    order_items.order(:ship_month).each do |e|
      sd = e.ship_month.strftime("%B %Y") rescue ''
      if h[sd]
        h[sd]+=e.item_total
      else
        h[sd]=e.item_total
      end
    end
    h
  end

  def validate_order_item
    #errors[:base] << "add at least one item to the order" if order_items.blank?
    errors.add(:products, "add at least one item to the order" ) if order_items.blank?
  end
end
