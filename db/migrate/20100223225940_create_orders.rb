class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.string :email
      t.decimal :sub_total, :precision => 6, :scale => 2
      t.decimal :sales_tax, :precision => 6, :scale => 2
      t.decimal :total, :precision => 6, :scale => 2
      t.timestamps
    end

		create_table :orders_products, :id => false do |t|
			t.integer :order_id
			t.integer :product_id
		end
  end

  def self.down
		drop_table :orders_products
    drop_table :orders
  end
end
