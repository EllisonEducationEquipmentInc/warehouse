class AddStartDateToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :start_date, :date
    add_column :products, :min_qty, :integer, :default => 1
  end

  def self.down
    remove_column :products, :min_qty
    remove_column :products, :start_date
  end
end
