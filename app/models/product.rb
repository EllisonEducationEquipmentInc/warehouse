class Product < ActiveRecord::Base
	validates_presence_of :item_num, :price
	has_many :order_items
	has_many :orders, :through => :order_items
	
	named_scope :active, :conditions => ['deleted = ?', false]
	
	
	def destroy
  	update_attribute :deleted, true
  end
end
