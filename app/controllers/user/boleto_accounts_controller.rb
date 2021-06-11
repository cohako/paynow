class User::BoletoAccountsController < User::UserController
  before_action :set_boleto_method
  before_action :set_company

  def show
    @boleto_account = BoletoAccount.find(params[:id])
  end
  
  def new
    @boleto_account = BoletoAccount.new
  end

  def create
    if @boleto_account = @client_company.boleto_accounts.create(boleto_params)
      redirect_to user_client_company_boleto_account_path(@client_company.id, @boleto_account.id)
    else
    end
  end

  private

  def boleto_params
    params.require(:boleto_account).permit(:bank_code, 
                                          :agency_code, 
                                          :account_number, 
                                          :payment_method_id, 
                                          :client_company_id)
  end

  def set_boleto_method
    @payment_boleto = PaymentMethod.where(payment_type: :boleto)
  end
  def set_company
    @client_company = ClientCompany.find(params[:client_company_id])
  end
end
