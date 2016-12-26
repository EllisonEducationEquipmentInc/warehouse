class UserMailer < ApplicationMailer
  default from: "pos@ellison.com"

  def order_confirmation(order)
    @order = order
    mail(to: @order.email, subject: 'Pre-order confirmation')
  end

  def params
    {}
  end
end
