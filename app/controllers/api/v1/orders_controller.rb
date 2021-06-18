class Api::V1::OrdersController < Api::V1::ApiController
  def index
    @client_company = ClientCompany.find_by(token: params[:company_token])
    @orders = @client_company.orders
    render json: @orders.as_json( 
                                except: [:id, 
                                :create_at, 
                                :client_company_id, 
                                :client_product_id, 
                                :client_external_id,
                                :card_number,
                                :print_name,
                                :card_cvv,
                                :boleto_address,
                                :updated_at],
                              ),
                                status: 201
  end
  def show
    @order = Order.find_by!(order_token: params[:order_token])
    render json: @order.as_json( 
                  except: [:id, :create_at, 
                  :client_company_id, 
                  :client_product_id, 
                  :client_external_id,
                  :card_number,
                  :print_name,
                  :card_cvv,
                  :boleto_address,
                  :updated_at]),
                  status: 201
  end

  def create
    @client_company = ClientCompany.find_by(token: order_params[:company_token])
    @client_external = ClientExternal.find_by(client_external_token: order_params[:client_token])
    @client_product = ClientProduct.find_by(product_token: order_params[:product_token])
    @order = Order.new(order_params)
    if @client_company && @client_external && @client_product
    @order.price_discounted = apply_discount(@client_product, @order)
    @order.price = @client_product.price
    @order.client_company_id = @client_company.id
    @order.client_product_id = @client_product.id
    @order.client_external_id = @client_external.id
    end
    @order.save!
    render json: @order.as_json( 
                                except: [:id, :create_at, 
                                :client_company_id, 
                                :client_product_id, 
                                :client_external_id,
                                :card_number,
                                :print_name,
                                :card_cvv,
                                :boleto_address,
                                :updated_at]),
                                status: 201
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
    price = client_product.price
    if order.pix?
      discount = client_product.pix_discount
    elsif order.boleto?
      discount = client_product.boleto_discount
    else
      discount = client_product.card_discount
    end
    price_discounted = price-((price*discount)/100)
  end
end