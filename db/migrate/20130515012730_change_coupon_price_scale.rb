class ChangeCouponPriceScale < ActiveRecord::Migration
  def up
     change_column :products, :coupon_price_1, :decimal, :precision => 6, :scale => 2
     change_column :products, :coupon_price_2, :decimal, :precision => 6, :scale => 2
     change_column :products, :coupon_price_3, :decimal, :precision => 6, :scale => 2
     change_column :products, :coupon_price_4, :decimal, :precision => 6, :scale => 2
     change_column :products, :coupon_price_5, :decimal, :precision => 6, :scale => 2
  end

  def down
  end
end
