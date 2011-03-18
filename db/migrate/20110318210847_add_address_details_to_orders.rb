class AddAddressDetailsToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :first_name, :string
    add_column :orders, :last_name, :string
    add_column :orders, :city, :string
    add_column :orders, :state, :string
    add_column :orders, :zip_code, :string
    add_column :orders, :country, :string
  end

  def self.down
    remove_column :orders, :country
    remove_column :orders, :zip_code
    remove_column :orders, :state
    remove_column :orders, :city
    remove_column :orders, :last_name
    remove_column :orders, :first_name
  end
end
