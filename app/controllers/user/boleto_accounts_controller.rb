require 'csv'
class User::BoletoAccountsController < User::UserController
  
  before_action :set_boleto_account, only: %i[show edit update destroy set_boleto_method]
  before_action :set_boleto_method, onlye: %i[new create edit update]
  before_action :set_company, only: %i[new create edit update]
  before_action :set_banks, only: %i[new create edit update]

  def index
    @boleto_accounts = BoletoAccount.all
  end

  def show
  end
  
  def new
    @boleto_account = BoletoAccount.new
  end

  def create
    @boleto_account = @client_company.boleto_accounts.new(boleto_params)
    if @boleto_account.save
      flash[:notice] = t('.success')
      redirect_to user_client_company_boleto_account_path(@client_company.id, @boleto_account.id)
    else
      render :new, notice: t('.fail')
    end
  end

  def update
    if @boleto_account.update(boleto_params)
      flash[:notice] = t('.success')
      redirect_to user_client_company_boleto_account_path(@boleto_account)
    else
      flash[:notice] = t('.fail')
      render :edit
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

  def set_boleto_account
    @boleto_account = BoletoAccount.find(params[:id])
  end

  def set_boleto_method
    @payment_boleto = PaymentMethod.where(payment_type: :boleto)
  end

  def set_company
    @client_company = ClientCompany.find(params[:client_company_id])
  end

  def set_banks
    bank = File.read(Rails.root.join('lib/assets/csv/bancos.csv'))
    @banks = CSV.parse(File.read(Rails.root.join('lib/assets/csv/bancos.csv'))).map { |code, name| [code+'<>'+name, code] }
  end
end
