class AddCouponCodeToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :full_name, :string
    add_column :orders, :coupon_code, :string
  end
end
