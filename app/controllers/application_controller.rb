class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :all
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :app_mode, :tradeshow?, :warehouse?, :order_name, :order_prefix

  before_action :authenticate_user!
  before_action :authenticate_admin!

protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :employee_number])
  end

private

  def authenticate_admin!
    redirect_to new_user_session_path, alert: "Unathorized!", status: 403 and return false unless devise_controller? || current_user.is_admin?
  end

  def app_mode
    TRADESHOW ? "Trade show" : "Warehouse"
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
