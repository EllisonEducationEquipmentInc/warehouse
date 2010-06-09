class RemoveHabt < ActiveRecord::Migration
  def self.up
		drop_table :orders_products
		execute "truncate orders"
  end

  def self.down
  end
end
