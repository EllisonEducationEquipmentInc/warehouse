class AddEmployeeNumberToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :employee_number, :string
  end
end
