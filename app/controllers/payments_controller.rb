# encoding: utf-8
class PaymentsController < ApplicationController
  def index
    @order = Order.where(status: [-1, 0], id: params[:order_id]).first
    unless @order.nil?
      #if @order.sum == params[:sum]
        @order.transaction_id = DateTime.now.to_i
        @order.transaction_date = DateTime.now
        @order.date_start = DateTime.now
        @order.date_end = @order.date_start + @order.pricelist.period.days # TODO: FIX IT TO period.hours !!!
        @order.quantity_remained = @order.pricelist.quantity
        @order.status = 1
        @order.save
      #end
      redirect_to user_subscriptions_path #, notice: "Заказ успешно оплачен. Подписка активирована."
    else
      redirect_to user_subscriptions_path #, flash: { error: "404 - страница не найдена." }
    end
  end
end
