class Admin::OrdersController < Admin::AdminController
  before_action :set_order, only: %i[show]

  def show
    return @receipt = @order.build_receipt if @order.pendente?
    @receipt = @order.receipt
  end

  private
  
  def set_order
    @order = Order.find_by(order_token: params[:order_token])
  end
end
