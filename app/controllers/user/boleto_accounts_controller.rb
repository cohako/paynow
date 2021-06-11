class User::BoletoAccountsController < User::UserController
  before_action :set_boleto_method
  before_action :set_company

  def new
    @boleto_account = BoletoAccount.new
  end
  def create
    @boleto_account = BoletoAccount.new(boleto_params)
    @boleto_account.client_company_id = current_user.client_company_id
  end

  private

  def boleto_params
    params.require(:boleto_account).permit(:bank_code, :agency_code, :account_number, :payment_method_id, :client_company_id)
  end

  def set_boleto_method
    @payment_boleto = PaymentMethod.where(payment_type: :boleto)
  end
  def set_company
    @client_company = current_user.client_company_id
  end
end