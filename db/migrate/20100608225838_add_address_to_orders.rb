class AddAddressToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :business, :string
    add_column :orders, :contact, :string
    add_column :orders, :phone, :string
    add_column :orders, :address, :string
    add_column :orders, :notes, :text
  end

  def self.down
    remove_column :orders, :notes
    remove_column :orders, :address
    remove_column :orders, :phone
    remove_column :orders, :contact
    remove_column :orders, :business
  end
end
