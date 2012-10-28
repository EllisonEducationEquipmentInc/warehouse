class AddIndexToCustomers < ActiveRecord::Migration
  def change
    add_index :customers, :ax_customer_number
    add_index :customers, :company_name
    add_index :customers, :zip
  end
end
