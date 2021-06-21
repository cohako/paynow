class Admin::OrdersController < Admin::AdminController
  before_action :set_order, only: %i[show]

  def show
    if @order.pendente?
      @refused = @order.refused_histories.new
      @receipt = @order.build_receipt
    else
    @receipt = @order.receipt
    end
    
  end

  private

  def set_order
    @order = Order.find_by(order_token: params[:order_token])
  end
end
