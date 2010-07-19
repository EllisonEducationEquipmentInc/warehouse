class ChangeTotalInOrders < ActiveRecord::Migration
  def self.up
		change_column :orders, :total, :decimal, :precision => 12, :scale => 2
		change_column :order_items, :item_total, :decimal, :precision => 10, :scale => 2
  end

  def self.down
  end
end
