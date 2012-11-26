class OrderItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :order
  
  before_save :calculate_item_total
  
  attr_accessor :should_destroy

  def should_destroy?
    should_destroy.to_i == 1
  end

  def item_total
    read_attribute(:price) * read_attribute(:quantity)
  end

  def product_id_with_start_date
    if ship_month.blank?
      product.id_with_start_date
    else
      sm = ship_month.beginning_of_month.strftime("%Y-%m-%d")
      "#{product.id}-#{sm}"
    end
  end

private

  def calculate_item_total
    write_attribute :item_total, item_total
  end
end
