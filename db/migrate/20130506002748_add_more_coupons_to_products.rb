class AddMoreCouponsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :coupon_3, :string
    add_column :products, :coupon_4, :string
    add_column :products, :coupon_5, :string
    add_column :products, :coupon_price_3, :decimal
    add_column :products, :coupon_price_4, :decimal
    add_column :products, :coupon_price_5, :decimal
  end
end
