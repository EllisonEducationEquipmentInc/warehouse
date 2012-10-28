class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :ax_customer_number
      t.string :company_name
      t.string :full_name
      t.string :customer_class
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :country
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
