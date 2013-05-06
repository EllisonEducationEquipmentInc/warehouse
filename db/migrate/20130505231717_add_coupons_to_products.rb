class AddCouponsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :coupon_1, :string
    add_column :products, :coupon_2, :string
    add_column :products, :coupon_price_1, :decimal
    add_column :products, :coupon_price_2, :decimal
  end
end
