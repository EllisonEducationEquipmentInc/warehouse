class Customer < ActiveRecord::Base

  validates_presence_of :ax_customer_number, :company_name
end
