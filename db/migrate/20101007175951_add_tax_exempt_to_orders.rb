class AddTaxExemptToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :tax_exempt, :boolean, :default => false
    add_column :orders, :tax_exempt_number, :string
  end

  def self.down
    remove_column :orders, :tax_exempt_number
    remove_column :orders, :tax_exempt
  end
end
