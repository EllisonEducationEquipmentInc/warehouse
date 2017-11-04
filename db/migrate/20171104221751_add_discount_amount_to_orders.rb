class AddDiscountAmountToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :discount_amount, :decimal, precision: 12, scale: 2, default: 0.0
  end
end
