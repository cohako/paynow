class Admin::RefusedHistoriesController < Admin::AdminController
  before_action :set_order, only: %i[show create]
  
  def show

  end

  def create
    @refused = @order.refused_histories.new(refused_params)
    if @refused.save
      flash[:notice] = t('.success')
      redirect_to admin_order_path(@order.order_token)
    else
      @receipt = @order.build_receipt
      flash[:notice] = t('.fail')
      render 'admin/orders/show'
    end
  end

  private

  def set_order
    @order = Order.find_by(order_token: params[:order_order_token])
  end

  def refused_params
    params.require(:refused_history).permit(:attempt, :returned_code)
  end
end