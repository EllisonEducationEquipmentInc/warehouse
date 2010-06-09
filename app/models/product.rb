class Product < ActiveRecord::Base
	validates_presence_of :item_num, :price
	has_many :order_items
	has_many :orders, :through => :order_items
end
