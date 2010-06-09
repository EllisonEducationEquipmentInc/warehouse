class AddIndexes < ActiveRecord::Migration
  def self.up
    add_index :products, :item_num
    add_index :products, :upc
  end

  def self.down
    remove_index :products, :upc
    remove_index :products, :item_num
  end
end
