class Admin::ReceiptsController < Admin::AdminController
  before_action :set_order, only: %i[show create]
  
  def show
    @receipt = @order.receipt
  end

  def new
    @order = Order.find_by(order_token: params[:order_token])
    @receipt = @order.build_receipt
  end
  def create
    @receipt = @order.build_receipt(receipts_params)
    if @receipt.save
      @order.aprovada!
      flash[:notice] = t('.success')
      redirect_to admin_order_receipt_path(@order.order_token, @receipt.receipt_token)
    else
      @refused = @order.refused_histories.new
      render 'admin/orders/show'
      #redirect_to admin_order_path(@order.order_token)
    end
  end

  private

  def set_order
    @order = Order.find_by(order_token: params[:order_order_token])
  end

  def receipts_params
    params.require(:receipt).permit(:payment_date, :auth_code)
  end
end