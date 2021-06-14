class User::ClientProduct < ApplicationController
  before_action :set_client_company, only: %i[create]

  # def new
  #   @client_product = ClientProduct.new
  # end

  def create
    @client_product = @client_company.clientProduct.new(clientcompany_params)
    if @client_product.save
      redirect_to user_client_company_client_product_path(@client_produt)
    else
      render :new
    end
  end

  private

  def product_params
    params.require(:client_product).permit(:name, 
      :price, :pix_discount, :card_discount, :boleto_discount)
  end

  def set_client_company
    @client_company = ClientCompany.find(params[:client_company_id])
  end
end