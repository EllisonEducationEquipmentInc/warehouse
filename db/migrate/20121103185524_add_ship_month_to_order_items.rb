class AddShipMonthToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :ship_month, :Date
  end
end
