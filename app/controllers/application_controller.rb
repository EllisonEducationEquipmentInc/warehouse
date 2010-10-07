class ApplicationController < ActionController::Base
  protect_from_forgery
	helper :all 
	before_filter :prepare_for_mobile 
	
	helper_method :app_mode, :tradeshow?, :warehouse?, :order_name, :order_prefix
	
private  
  def mobile_device?  
		if session[:mobile_param]  
      session[:mobile_param] == "1"  
    else  
      request.user_agent =~ /Mobile|webOS/  
    end
  end  
  helper_method :mobile_device?

	def prepare_for_mobile  
    session[:mobile_param] = params[:mobile] if params[:mobile]  
		request.format = :mobile if mobile_device? 
  end
  
  def app_mode
    TRADESHOW ? "Trade show" : "Wharehouse"
  end
  
  def tradeshow?
    TRADESHOW
  end
  
  def warehouse?
    !tradeshow?
  end
  
  def order_name
    tradeshow? ? 'Quote' : 'Order'
  end
  
  def order_prefix
    warehouse? ? "WHS" : "CHA"
  end
end
