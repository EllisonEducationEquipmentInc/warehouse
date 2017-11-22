class AddCustomerNumberIndexToOrders < ActiveRecord::Migration
  def change
    add_index :orders, :customer_number
  end
end
