class AddItemTotalToOrderItems < ActiveRecord::Migration
  def self.up
    add_column :order_items, :item_total, :decimal, :precision => 8, :scale => 2
  end

  def self.down
    remove_column :order_items, :item_total
  end
end
