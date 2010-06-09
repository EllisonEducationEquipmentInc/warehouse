class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :item_num
      t.string :name
      t.string :upc
      t.decimal :price, :precision => 6, :scale => 2

      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
