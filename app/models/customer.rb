class Customer < ActiveRecord::Base
  attr_accessible :address, :ax_customer_number, :city, :company_name, :country, :customer_class, :email, :full_name, :phone, :state, :zip

  validates_presence_of :ax_customer_number, :company_name
end
