class User::ClientProductsController < User::UserController
  before_action :set_product, only: %i[show edit update]
  before_action :set_company, only: %i[new create]

  def index
    @client_products = ClientProduct.where(client_company_id: current_user.client_company_id)
  end

  def show
  end

  def new
    @client_product = ClientProduct.new
  end

  def create
    @client_product = @client_company.client_product.new(product_params)
    if @client_product.save
      flash[:notice] = t('.success')
      redirect_to user_client_company_client_product_path(@client_product.client_company.token, @client_product)
    else
      flash[:notice] = t('.fail')
      render :new
    end
  end

  def edit
  end

  def update
    if @client_product.update(product_params)
      flash[:notice] = t('.success')
      redirect_to user_client_company_client_product_path(@client_product.client_company.token, @client_product)
    else
      flash[:notice] = t('.fail')
      render :edit
    end
  end

  private

  def product_params
    params.require(:client_product).permit(:name, 
                                          :price, 
                                          :pix_discount, 
                                          :card_discount, 
                                          :boleto_discount,
                                          :client_company_id)
  end

  def set_product
    @client_product = ClientProduct.find_by(params[product_token: :product_token])
  end

  def set_company
    @client_company = ClientCompany.find_by(params[token: :client_company_token])
  end
end