class Api::V1::OrdersController < Api::V1::ApiController
  def create
    @order = Order.new(order_params)
    @client_company = ClientCompany.find_by(token: order_params[:company_token])
    @client_external = ClientExternal.find_by(client_external_token: order_params[:client_token])
    @client_product = ClientProduct.find_by(product_token: order_params[:product_token])
    if @client_company && @client_external && @client_product
    @order.price_discounted = apply_discount(@client_product, @order)
    @order.price = @client_product.price
    @order.client_company_id = @client_company.id
    @order.client_product_id = @client_product.id
    @order.client_external_id = @client_external.id
    end
    @order.save!
    render json: @order, status: 201
  end

  private

  def order_params
    params.require(:order).permit(:payment_type,
                                  :payment_id, 
                                  :company_token, 
                                  :product_token,
                                  :client_token,
                                  :card_number,
                                  :print_name,
                                  :card_cvv,
                                  :boleto_address)
  end

  def apply_discount(client_product, order)
    if order.pix?
      price = client_product.price
      discount = client_product.pix_discount
      price_discounted = price-((price*discount)/100)
    end
  end
end